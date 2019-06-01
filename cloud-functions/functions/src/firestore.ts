import * as fbAdmin from "firebase-admin";
import { DocumentSnapshot} from "firebase-functions/lib/providers/firestore";

export const admin = fbAdmin;
export const fs = admin.firestore();
export const fsImp = admin.firestore;

export async function getParentDocData(snapshot: DocumentSnapshot) {
    return (await getParentDoc(snapshot)).data();
}

export async function getParentDoc(snapshot: DocumentSnapshot) {
    const parent = snapshot.ref.parent.parent;
    return (await parent.get());
}

export async function getAccountData(accountId: string) {
    return (await collectionAccount().doc(accountId).get()).data();
}

export function docAccount(accountId: string) {
    return collectionAccount().doc(accountId);
}

export function collectionAccount() {
    return fs.collection('account');
}

export function collectionAccountFriends(accountId: string){
    return docAccount(accountId).collection('friends');
}

export function collectionAccountStrikes(accountId: string) {
    return docAccount(accountId).collection('strikes');
}

export function collectionAccountPosts(accountId: string) {
    return docAccount(accountId).collection('posts');
}

export function collectionAccountGoals(accountId: string) {
    return docAccount(accountId).collection('goals');
}


export function collectionAccountContent(accountId: string) {
    return docAccount(accountId).collection('content');
}

export function collectionAccountFcms(accountId: string) {
    return docAccount(accountId).collection('fcm');
}

export function collectionAccountFeed(accountId: string) {
    return docAccount(accountId).collection('feed');
}

export function collectionReceivedFriendRequests(accountId: string) {
    return docAccount(accountId).collection('receivedFriendRequests');
}

export function collectionSentFriendRequests(accountId: string) {
    return docAccount(accountId).collection('sentFriendRequests');
}

export function collectionAccountPostComments(accountId: string, postId: string) {
    return collectionAccountPosts(accountId).doc(postId).collection('comments');
}

export function collectionChallenge() {
    return fs.collection('challenge');
}

export async function deleteDoc(reference: fbAdmin.firestore.DocumentReference) {
    const path: string = reference.path;
    console.log("Removing from DB: " + path);
    fs.doc(path).delete().then(
            (val: fbAdmin.firestore.WriteResult) => console.log("Delete result: " + val)
        ).catch(
            (error) => console.log(error)
        );
}