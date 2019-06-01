import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();
const storage = admin.storage();

import { collectionAccountContent, collectionAccountFriends } from '../../firestore'

import { DocumentReference, WriteBatch, CollectionReference } from '@google-cloud/firestore';

async function updateNameInFriendLists(accountId: string, newName: string, batch: WriteBatch) {
    const colRef: CollectionReference = collectionAccountFriends(accountId);
    const friendDocRefs: DocumentReference[] = await colRef.listDocuments();
    friendDocRefs.forEach(docRef => {
        const entry = collectionAccountFriends(docRef.id).doc(accountId);
        batch.update(entry, {});
    });
};

// TODO Finish
export function onNameChange(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/account/{accountId}')
    .onUpdate(async (snapshot, context) => {
        const before = snapshot.before.data();
        const after = snapshot.after.data();

        if (before.name !== after.name) {
            const docRefs: FirebaseFirestore.DocumentReference[] = await collectionAccountContent(before.accountId).listDocuments();
            const batch: WriteBatch = firestore.batch();
            await updateNameInFriendLists(after.accountId, after.name, batch);
            await updateNameInGdprRegister(docRefs, batch);
            await batch.commit();
        }
    });
} 

async function updateNameInGdprRegister(docRefs: DocumentReference[], batch: WriteBatch) {
    docRefs.forEach(async ref => {
        const collections: CollectionReference[] = await ref.listCollections();
        collections.forEach(async (colRef) => {
            const colDocsRefs: DocumentReference[] = await colRef.listDocuments();

            // TODO handle the different content types.
            // TODO keep the different content separate such as this operation doesn't need to get every document to check how to update it. 

            batch.update(ref, {});
        });

    });
};

/* export const httpTest = functions.https.onRequest((req, res) => {
    res.sendFile
}) */

// Images will be a challenge. What format should this info be in?

// TODO handle request modify data on user - name change.