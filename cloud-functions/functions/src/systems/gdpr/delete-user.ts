import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();
const storage = admin.storage();

import { collectionAccountContent, collectionAccountFriends, collectionReceivedFriendRequests, collectionAccount, collectionAccountFeed, collectionAccountPosts, collectionAccountGoals } from '../../firestore'
import { DocumentSnapshot } from 'firebase-functions/lib/providers/firestore';
import { ContentType } from '../../enums';
import { DocumentReference, WriteBatch, CollectionReference, DocumentData, WriteResult } from '@google-cloud/firestore';

export function onCreateGdprReferenceComment() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/account/{accountId}/posts/{postId}/comments/{commentId}')
        .onCreate(async (snapshot) => {
            const data = snapshot.data();
            const accountId = data.account.accountId;
            const reference = snapshot.ref;
            await addReference(accountId, reference, ContentType.comment);
        });
}


export function onCreateGdprReferenceFriendRequest() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/account/{accountId}/sentFriendRequests/{sentFriendRequestId}')
        .onCreate(async (snapshot) => {
            const data = snapshot.data();
            const senderId = data.sender.accountId;
            const recipientId = data.recipient.accountId;
            const reference = collectionReceivedFriendRequests(recipientId).doc(senderId);
            await addReference(senderId, reference, ContentType.friendRequest);
        });
}

/**
 * Used for storing references about content that this user have created with personally 
 * identifiable data in that exist outside this person's account document.
 * @param accountId The account id of the user.
 * @param reference The reference to the content outside the user's profile.
 * @param type A enum value depicting the type of content.
 */
async function addReference(accountId: string, reference: DocumentReference, type: ContentType) {
    await collectionAccountContent(accountId).doc().set({
        reference: reference,
        type: type
    })
}

// Used in the deletion of a user, it removes all collections belonging to a document and the documents within them.
/**
 * Hierarchically deletes from the document specified.
 * @param docSnapshot The document that should be deleted along with it's sub-collections 
 * @param batch The batch this operation is executed in.
 */
async function onRecursiveDeletion(docSnapshot: DocumentSnapshot, batch: WriteBatch) {
    const collections: CollectionReference[] = await docSnapshot.ref.listCollections();
    collections.forEach(async (colRef) => {
        const colDocsRefs: DocumentReference[] = await colRef.listDocuments();
        colDocsRefs.forEach(async (docRef) => {
            const subDocument = await docRef.get();
            await onRecursiveDeletion(subDocument, batch);
        });
    });

    const data = (await docSnapshot.ref.get()).data()
    batch.delete(docSnapshot.ref);
};

/**
 * Deletes the references documents that are stored outside the users account document.
 * @param accountId The account the content belongs to.
 * @param batch The batch that is used to delete all the documents in the account document.
 */
async function accountContentDeletion(accountId: string) {

    const registryCollection: CollectionReference = collectionAccountContent(accountId);
    const listOfDocRefs: DocumentReference[] = await registryCollection.listDocuments();

    listOfDocRefs.forEach(async ref => {
        // Obtain the DocumentData referenced in the registry.
        const data: DocumentData = (await ref.get()).data();

        // Delete the reference and the pointer in the registry.
        //batch.delete(data.reference);
        const reference: DocumentReference = data.reference;
        await reference.delete();
        await ref.delete();
        //batch.delete(ref);
    });
};

async function onRemoveFromFriendsProfile(accountId: string) {
    const batch: WriteBatch = firestore.batch();

    const colRef: CollectionReference = collectionAccountFriends(accountId);
    const friendDocRefs: DocumentReference[] = await colRef.listDocuments();
    friendDocRefs.forEach(docRef => {
        // Delete the user from the friendlist of the friend.
        const friendEntry = collectionAccountFriends(docRef.id).doc(accountId);
        batch.delete(friendEntry);

        // Delete the user from the friendlist of the user who initiated the delete.
        const myEntry = collectionAccountFriends(accountId).doc(docRef.id);
        batch.delete(myEntry);
    });

    return batch.commit();
};

async function accountStorageBucketDeletion(accountId: string) {
    return storage.bucket("user/" + accountId).delete();
};

/* 
async function deleteFcms(accountId: string, batch: WriteBatch){
    const colRef: CollectionReference = collectionAccountFcms(accountId);
    const fcmsDocRefs: DocumentReference[] = await colRef.listDocuments();
    fcmsDocRefs.forEach(docRef => {
        const entry = collectionAccountFcms(accountId).doc(docRef.id);
        batch.delete(entry);
    });
};

async function deleteFeed(accountId: string, batch: WriteBatch){
    const colRef: CollectionReference = collectionAccountFeed(accountId);
    const feedDocRefs: DocumentReference[] = await colRef.listDocuments();
    feedDocRefs.forEach(docRef => {
        const entry = collectionAccountFeed(accountId).doc(docRef.id);
        batch.delete(entry);
    });
};

async function deleteStrikes(accountId: string, batch: WriteBatch){
    const colRef: CollectionReference = collectionAccountStrikes(accountId);
    const strikeDocRefs: DocumentReference[] = await colRef.listDocuments();
    strikeDocRefs.forEach(docRef => {
        const entry = collectionAccountStrikes(accountId).doc(docRef.id);
        batch.delete(entry);
    });
}; */

async function deletePostInFriendFeeds(accountId: string, postId: string){

    const friendListPath = '/account/' + accountId + '/friends';
    const friendQuerySnapshot = await firestore.collection(friendListPath).get();

    // Tell the batch to update the feeds of all the friends.
    friendQuerySnapshot.forEach(async doc => {
        const friendFeedRef = '/account/' + doc.id + '/feed/' + postId;
        const friendFeedDoc = firestore.doc(friendFeedRef);
        await friendFeedDoc.delete();
    });
}

async function onDeletePosts(accountId: string){

    const colRef: CollectionReference = collectionAccountPosts(accountId);
    const feedDocRefs: DocumentReference[] = await colRef.listDocuments();
    feedDocRefs.forEach(async docRef => {
        await deletePostInFriendFeeds(accountId, docRef.id);
        await docRef.delete();
    });
};

async function onDeleteGoals(accountId: string){

    const colRef: CollectionReference = collectionAccountGoals(accountId);
    const goalDocRefs: DocumentReference[] = await colRef.listDocuments();
    goalDocRefs.forEach(async docRef => {
        await docRef.delete();
    });
};

async function onDeleteFeed(accountId: string){
    const colRef: CollectionReference = collectionAccountFeed(accountId);
    (await colRef.listDocuments()).forEach(async docRef => {
        await docRef.delete();
    });
};


export function onUserDeletion() {
    return functions
        .region('europe-west1')
        .auth.user()
        .onDelete(async (user) => {
            const accountDoc: DocumentSnapshot = await collectionAccount().doc(user.uid).get();
            console.log("Account to delete: " + accountDoc.ref.path);

            // todo delete posts before friends so they are removed from friends feeds
            console.log("1/6 - Deleting posts - assuring they are removed from friends feeds");
            await onDeletePosts(user.uid);

            console.log("2/7 - Deleting goals");
            await onDeleteGoals(user.uid);

            console.log("3/7 - Deleting feed");
            await onDeleteFeed(user.uid);

            console.log("4/7 - Deleting account from friends profile");
            await onRemoveFromFriendsProfile(user.uid);

            console.log("5/7 - Deleting content from account, comments friend-requests, etc");
            await accountContentDeletion(user.uid);

            console.log("6/7 - Deleting account storage bucket");
            await accountStorageBucketDeletion(user.uid).catch((error) => console.log(error))

            console.log("7/7 - Deleting account document");
            await accountDoc.ref.delete();

            //console.log("4/4 - Deleting remaining elements in account");
            
/*             const batch: WriteBatch = firestore.batch();
            await onRecursiveDeletion(accountDoc, batch);
            await batch.commit(); */

            console.log("Account deleted: " + accountDoc.ref.path);
        });
} 