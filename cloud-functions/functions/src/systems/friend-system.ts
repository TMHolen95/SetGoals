import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();

import { sendMessage } from "../notifications";
import { NotificationType, PointType } from "../enums";
import { rewardPoints } from './point-system';

export function onFriendRequest(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/account/{accountId}/receivedFriendRequests/{senderId}')
    .onCreate(async (snapshot, context) => {
        const data = snapshot.data();
        const recipientAccountId = data['recipient']['accountId'];
        const senderName = data['sender']['name'];
        await sendMessage(recipientAccountId, 'New Friend Request!', "You have a friend request from \n" + senderName, NotificationType.friendRequestReceived, data['sender']['accountId'], '');
    });
}

export function onFriendRequestResponse(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/account/{accountId}/receivedFriendRequests/{senderId}')
    .onUpdate((change, context) => {
        const after = change.after.data();

        // Just to be absolutely certain this Cloud Function won't loop
        if (after.accepted !== null) {
            const requestAccepted = after.accepted;
            const senderPath = '/account/' + after.sender.accountId;
            const recipientPath = '/account/' + after.recipient.accountId;

            const batch = firestore.batch();

            // Add the new friends to the respective friendlist documents.
            if (requestAccepted) {
                const sendersNewFriendDoc = firestore.doc(senderPath + '/friends/' + after.recipient.accountId);
                batch.set(sendersNewFriendDoc, after.recipient);

                const recipientsNewFriendDoc = firestore.doc(recipientPath + '/friends/' + after.sender.accountId);
                batch.set(recipientsNewFriendDoc, after.sender);
            }

            // Delete the friend request documents as they are redundant.
            const sendersHandledFriendRequest = firestore.doc(senderPath + '/sentFriendRequests/' + after.recipient.accountId);
            batch.delete(sendersHandledFriendRequest);

            const recipientsHandledFriendRequest = firestore.doc(recipientPath + '/receivedFriendRequests/' + after.sender.accountId);
            batch.delete(recipientsHandledFriendRequest);

            // Ensure that all events succeed through a atomic batch write operation
            return batch.commit().then(async (result) => {
                console.log("Successfully handled friend request response");
                if (requestAccepted) {
                    await sendMessage(after['sender']['accountId'], "New Friend!", after['recipient']['name'] + ' accepted your friend request', NotificationType.friendRequestAccepted, after.recipient.accountId, '');
                }

            }).catch((error) => {
                console.log("Erroneously handled friend request response");
            });
        }
        return Promise.reject("Request response was null");
    });
}

async function updateFriendCount(snapshot: FirebaseFirestore.DocumentSnapshot, context: functions.EventContext) {
    const accountRef = firestore.doc('account/' + context.params.accountId);
    const friendsQuery = snapshot.ref.parent;
    const querySnapshot = await friendsQuery.get()
    const friendCount = querySnapshot.size;
    return accountRef.update({ 'friendCount': friendCount });
}

export function onFriendAdded(){
    return functions
    .region('europe-west1')
    .firestore
    .document('account/{accountId}/friends/{friendId}')
    .onCreate(async (snapshot, context) => {
        const friend = snapshot.data();
        const accountId = friend.accountId;
        await rewardPoints(accountId, PointType.Social, 5, null);
        return updateFriendCount(snapshot, context);
    });
}

export function onFriendRemoved(){
    return functions
    .region('europe-west1')
    .firestore
    .document('account/{accountId}/friends/{friendId}')
    .onDelete(async (snapshot, context) => {
        return updateFriendCount(snapshot, context);
    });
}
