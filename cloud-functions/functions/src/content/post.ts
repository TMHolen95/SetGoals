import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();

import { PointType } from "../enums";
import { rewardPoints } from "../systems/point-system";

export function onNewPost() {
    return functions
    .region('europe-west1')
    .firestore
        .document('/account/{accountId}/posts/{postId}')
        .onCreate(async (snapshot, context) => {

            const postData = snapshot.data();
            const accountId = postData.goal.account.accountId;

            // Create a batch for quicker writes to firestore
            const batch = firestore.batch();

            if (postData.goal.public === true) {
                // Obtain a query containing the post owners friends
                const friendListPath = '/account/' + accountId + '/friends';
                const friendQuerySnapshot = await firestore.collection(friendListPath).get();

                // Tell the batch to update the feeds of all the friends.
                friendQuerySnapshot.forEach(doc => {
                    const friendFeedRef = '/account/' + doc.id + '/feed/' + postData.postId;
                    const friendFeedDoc = firestore.doc(friendFeedRef);
                    batch.set(friendFeedDoc, postData);
                });

                // Reward five social points for posting publicly
                await rewardPoints(accountId, PointType.Social, 5, batch);
            }

            // Reward activity points for progressing with goals
            // TODO reward extra activity points for like on posts
            const state = postData.goal.state;
            if (state === 'completed') {
/*                 const accountDoc = await firestore.doc("/account/" + accountId);
                const accData = (await accountDoc.get()).data();
                accData["goalsCompleted"] = accData["goalsCompleted"] + 1;
                await accountDoc.set(accData); */

                await rewardPoints(accountId, PointType.Activity, 5, batch);
            } else if (state === 'progress') {
                await rewardPoints(accountId, PointType.Activity, 2, batch);
            }

            // Ensure that the post also appears in the post owners feed.
            const ownerFeedRef = '/account/' + accountId + '/feed/' + postData.postId;
            const ownerFeedDoc = firestore.doc(ownerFeedRef);
            batch.set(ownerFeedDoc, postData);

            // Update the goal with the latest state
            const ownerGoalRef = '/account/' + accountId + '/goals/' + postData.goal.goalId;
            const ownerGoalDoc = firestore.doc(ownerGoalRef);
            batch.update(ownerGoalDoc, postData.goal);

            // Assign default data for the posters main post
            const updateData = { 'commentCount': 0, 'likes': 0 };
            batch.update(snapshot.ref, updateData);

            // Atomically update the documents, all or nothing gets persisted to firestore
            batch.commit().then((result) => {
                console.log("Successfully updated the feed of friends!");
            }).catch((error) => {
                console.log(error);
                console.log("Failed to update feed of friends...");
            });

            const postSubscribers = (await snapshot.ref.collection('subscribers').doc('subscribers'));
            await postSubscribers.set({ 'subscribers': [accountId] });
        })
}


// TODO change the variables like friendListPath to use collections from firestore.ts
export function onDeletePost() {
    return functions
    .region('europe-west1')
    .firestore
        .document('/account/{accountId}/posts/{postId}')
        .onDelete(async (snapshot, context) => {

            const postData = snapshot.data();
            const accountId = postData.goal.account.accountId;

            // Create a batch for quicker writes to firestore
            const batch = firestore.batch();

            if (postData.goal.public === true) {
                // Obtain a query containing the post owners friends
                const friendListPath = '/account/' + accountId + '/friends';
                const friendQuerySnapshot = await firestore.collection(friendListPath).get();

                // Tell the batch to update the feeds of all the friends.
                friendQuerySnapshot.forEach(doc => {
                    const friendFeedRef = '/account/' + doc.id + '/feed/' + postData.postId;
                    const friendFeedDoc = firestore.doc(friendFeedRef);
                    batch.delete(friendFeedDoc, postData);
                });

                // Subtract five social points for removing post
                await rewardPoints(accountId, PointType.Social, -5, batch);
            }

            // User may have still completed it however spam-posting and removing should not be a incentive for obtaining points.
            const state = postData.goal.state;
            if (state === 'completed') {
                await rewardPoints(accountId, PointType.Activity, -5, batch);
            } else if (state === 'progress') {
                await rewardPoints(accountId, PointType.Activity, -2, batch);
            }

            // Ensure that the post is also deleted in the post owners feed.
            const ownerFeedRef = '/account/' + accountId + '/feed/' + postData.postId;
            const ownerFeedDoc = firestore.doc(ownerFeedRef);
            batch.delete(ownerFeedDoc, postData);

            // Atomically delete the documents, all or nothing gets persisted to firestore.
            batch.commit().then((result) => {
                console.log("Successfully deleted post in the feed of friends!");
            }).catch((error) => {
                console.log(error);
                console.log("Failed to delete the feed of friends...");
            });
        });
}