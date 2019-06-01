import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

import { sendMessage } from "../notifications";
import { NotificationType, PointType } from "../enums";
import { rewardPoints } from "../systems/point-system";

export function onComment() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/account/{accountId}/posts/{postId}/comments/{commentId}')
        .onCreate(async (snapshot, context) => {
            const comment = snapshot.data();
            if (comment === undefined) return null;
            if (snapshot === null) return null;

            const commentOwner = comment.account;
            const commentOwnerId = comment.account.accountId;
            //Obtain a querySnapshot if the user have commented before
            const usersComments = (await snapshot.ref.parent.where('account.accountId', "==", commentOwnerId).get()).size;
            const totalComments = (await snapshot.ref.parent.get()).size;

            console.log("Users comments: " + usersComments);
            console.log("Total comments: " + totalComments);

            //If the user haven't commented on this reward five points, but only if the user is not the poster.
            // Otherwise two points are rewarded as long as the user does not have more than 50% of the comments. 
            if (usersComments === 1 && comment.account.accountId !== context.params.accountId) {
                await rewardPoints(commentOwnerId, PointType.Social, 5, null);
            } else if (usersComments / totalComments <= 0.5) {
                await rewardPoints(commentOwnerId, PointType.Social, 2, null);
            } else {
                console.log("No points!");
            }

            // TODO send notifications that someone commented, to everyone except the one that commented
            const postDocument = snapshot.ref.parent.parent;
            const postData = (await postDocument.get()).data();
            const postSubscribers = postDocument.collection('subscribers').doc('subscribers');
            const subscribers = (await postSubscribers.get()).data();


            // TODO add support for muting the notifications.
            // Get the FCM tokens of the accounts that have commented
            if (subscribers !== undefined && postData !== undefined) {
                await subscribers['subscribers'].forEach(async (subscriber: string) => {
                    console.log("Subscriber: " + subscriber + ", Comment-owner: " + commentOwnerId);
                    if (subscriber !== commentOwnerId) {
                        sendMessage(subscriber, 'Post update!', commentOwner['name'] + ' commented on\n"' + postData['title'] + '"', NotificationType.comment, postData['goal']['account']['accountId'], postData['postId'])
                        .then(()=>console.log("Successfully sent notification!"))
                        .catch((e) => console.log(e));
                    }
                });

                const commentOwnerExists = subscribers['subscribers'].includes(commentOwnerId);
                console.log("Person has commented before: " + commentOwnerExists);

                if (!commentOwnerExists) {
                    subscribers['subscribers'].push(commentOwnerId);
                    postSubscribers.set(subscribers)
                        .then((res) => console.log("Successfully added the comment-owners' UID"))
                        .catch((err) => console.log("Could not add the comment-owners' UID")
                        );
                }

            }

            // Just to ensure nobody fakes the timestamps.
            return snapshot.ref.update({ timestamp: admin.firestore.Timestamp.now() });
        })

}


export function onDeleteComment() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/account/{accountId}/posts/{postId}/comments/{commentId}')
        .onDelete(async (snapshot, context) => {
            const comment = snapshot.data();
            const commentOwnerId = comment.account.accountId;

            // Subtract points for removing comment.
            await rewardPoints(commentOwnerId, PointType.Social, -5, null);

            // TODO consider doing deletions like Reddit-like fashion showing that a comment was deleted instead of nothing. 
        })
}