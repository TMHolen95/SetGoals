import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();

import { deleteDoc, collectionAccountStrikes, getParentDoc, getAccountData, collectionChallenge } from '../firestore'


import { DocumentSnapshot } from 'firebase-functions/lib/providers/firestore';
import { sendMessage } from '../notifications';
import { NotificationType, ReportType } from '../enums';

export function onReportUpdateChallenge(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedChallenge/{challengeId}')
    .onUpdate(async (snapshot, context) => {
        await handleReportCase(snapshot, ReportType.challenge);
    });
} 

export function onReportUpdateComment(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedComment/{commentId}')
    .onUpdate(async (snapshot, context) => {
        await handleReportCase(snapshot, ReportType.comment);
    });
} 

export function onReportUpdatePost(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedPost/{postId}')
    .onUpdate(async (snapshot, context) => {
        await handleReportCase(snapshot, ReportType.post);
    });
} 

async function handleReportCase(snapshot: functions.Change<DocumentSnapshot>, type: ReportType) {
    const before = snapshot.before.data();
    const after = snapshot.after.data();
    if (before !== undefined && after !== undefined) {
        // Ensure that the blocking process only is run when the acceptable criteria is changed to false
        if (before['acceptable'] !== after['acceptable'] && !after['acceptable']) {

            // Delete Resource
            const ref: admin.firestore.DocumentReference = after['reference'];
            await deleteDoc(ref);

            // Obtain the content creator's Id.
            let uid: string = "";
            switch (type) {
                case ReportType.challenge:
                    uid = after['creatorId'];
                    break;
                case ReportType.comment:
                    uid = after['account']['accountId'];
                    break;
                case ReportType.post:
                    uid = after['goal']['account']['accountId'];
                    break;
            }

            // Add a reprimand on the creator as the content is not acceptable.
            await reprimandUser(uid, type);
        }
    }
}

async function reprimandUser(accountId: string, type: ReportType) {
    const authorStrikes = collectionAccountStrikes(accountId);
    await authorStrikes.doc().set({ timestamp: admin.firestore.Timestamp.now(), type: type })

    // Check if three inappropriate content types have been sent the last week.
    const query = authorStrikes.where('timestamp', ">=", lastWeek()).where('type', '==', type);
    if ((await query.get()).docs.length >= 5) {
        // Delete/Disable account
        await admin.auth().updateUser(accountId, {
            disabled: true
        })
    }
}

function lastYear() {
    return new Date(new Date().setFullYear(new Date().getFullYear() - 1));
}

function lastWeek() {
    const today = new Date();

    const weeklySeconds = 60 * 60 * 24 * 7 * 1000; // * 1000 since we are not interested in milliseconds.
    const weekAgo = new Date();
    weekAgo.setTime(today.valueOf() - weeklySeconds);

    // console.log('Today: ' + today.toLocaleString());
    // console.log('Week ago?: ' + weekAgo.toLocaleString());

    return admin.firestore.Timestamp.fromDate(weekAgo);
}

export function onChallengeReported(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedChallenge/{challengeId}/reports/{accountId}')
    .onCreate(async (snapshot, context) => {
        await onReport(snapshot, ReportType.challenge);
    });
} 

export function onCommentReported(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedComment/{commentId}/reports/{accountId}')
    .onCreate(async (snapshot, context) => {
        await onReport(snapshot, ReportType.comment);
    });
} 

export function onPostReported(){
    return functions
    .region('europe-west1')
    .firestore
    .document('/reportedPost/{postId}/reports/{accountId}')
    .onCreate(async (snapshot, context) => {
        await onReport(snapshot, ReportType.post);
    });
} 

/**
 * 
 * @param snapshot The report submitted by the user.
 * @param type Either [ReportType.post], [ReportType.comment], or [ReportType.challenge]
 */
async function onReport(snapshot: DocumentSnapshot, type: ReportType) {
    const report = snapshot.data();

    // The object that was reported
    const doc: FirebaseFirestore.DocumentSnapshot = await getParentDoc(snapshot);
    const data = doc.data();
    

    let author: FirebaseFirestore.DocumentData;
    let pushBody: string;
    let pushTitle: string;
    switch (type) {
        case ReportType.challenge:
            author = getAccountData(data['creatorId']);
            pushBody = data['title'];
            pushTitle = 'Reported Challenge';
            break;
        case ReportType.comment:
            author = getAccountData(data['account']['creatorId']);
            pushBody = "A comment";
            pushTitle = 'Reported Comment';

            break;
        case ReportType.post:
            author = getAccountData(data['goal']['account']['accountId']);
            pushBody = data['title'];
            pushTitle = 'Reported Post';
            break;
    }

    console.log('author: ' + author);
    const notificationBody = reportNotificationBody(pushBody, report['reportReason'], author);

    console.log("doc: " + doc);
    console.log("doc.ref: " + doc.ref);
    console.log("doc.ref.path: " + doc.ref.path);

    await sendMessage('myzhtGtYzchuiptvmMNE6ssmfyz1', pushTitle, notificationBody, NotificationType.reportPost, report['accountId'], doc.ref.path);
}

function reportNotificationBody(contentTitle: string, reportReason: string, account: { [x: string]: any; }) {
    return '"' + contentTitle + '" was reported for ' + reportReason + '!\nChallenge Author is: ' + (account === undefined ? '[Deleted Account]' : account['name']);
}