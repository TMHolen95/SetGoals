import * as admin from 'firebase-admin';
const serviceAccount = require("../serviceAccountKey.json");

admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://z-goals.firebaseio.com",
    projectId: "z-goals",
    storageBucket: "z-goals.appspot.com",
});

const firestore = admin.firestore();
const settings = { timestampsInSnapshots: true };
firestore.settings(settings);

import {onFirstSignIn} from './first-sign-in';
exports.onFirstSignIn = onFirstSignIn();

import {onDeleteComment, onComment} from  './content/comment';
exports.onDeleteComment = onDeleteComment();
exports.onComment = onComment();

import {onDeletePost,onNewPost} from './content/post';
exports.onDeletePost = onDeletePost();
exports.onNewPost = onNewPost();

import {onDeleteChallenge,onNewChallenge} from './content/challenge';
exports.onDeleteChallenge = onDeleteChallenge();
exports.onNewChallenge = onNewChallenge();

import {onGoalAdded,onGoalRemoved,updateGoalAccomplished, onAddDefaultGoal} from './content/goal';
exports.onAddDefaultGoal = onAddDefaultGoal();
exports.onGoalAdded = onGoalAdded();
exports.onGoalRemoved = onGoalRemoved();
exports.updateGoalAccomplished = updateGoalAccomplished();


import {onFriendAdded,onFriendRemoved,onFriendRequest,onFriendRequestResponse} from './systems/friend-system';
exports.onFriendAdded = onFriendAdded();
exports.onFriendRemoved = onFriendRemoved();
exports.onFriendRequest = onFriendRequest();
exports.onFriendRequestResponse = onFriendRequestResponse();

// No cloud functions are present in the point-system.
// import {} from './systems/point-system';


import {onChallengeReported,onCommentReported,onPostReported,onReportUpdateChallenge,onReportUpdateComment,onReportUpdatePost} from './systems/report-system';
exports.onChallengeReported = onChallengeReported();
exports.onCommentReported = onCommentReported();
exports.onPostReported = onPostReported();
exports.onReportUpdateChallenge = onReportUpdateChallenge();
exports.onReportUpdateComment = onReportUpdateComment();
exports.onReportUpdatePost = onReportUpdatePost();


import {onCreateGdprReferenceComment,onCreateGdprReferenceFriendRequest,onUserDeletion} from './systems/gdpr/delete-user';
exports.onCreateGdprReferenceComment = onCreateGdprReferenceComment();
exports.onCreateGdprReferenceFriendRequest = onCreateGdprReferenceFriendRequest();
exports.onUserDeletion = onUserDeletion();

import {onNameChange} from './systems/gdpr/rename-user';
exports.onNameChange = onNameChange();

import {onDataLogging} from './content/data-logging';
exports.onDataLogging = onDataLogging();

import {onSampleAccounts, onSampleGoals, onSampleGoalLogEntries, onSampleReminders, onSamplePosts, onSampleResponses, onSampleRegisteredAccounts, onSampleComments} from './content/sampling/csv-bfi';
exports.onSampleAccounts = onSampleAccounts(); //31.05
exports.onSampleGoals = onSampleGoals(); // 31.05
exports.onSampleGoalLogEntries = onSampleGoalLogEntries(); //31.05
exports.onSampleReminders = onSampleReminders();//31.05
exports.onSamplePosts = onSamplePosts(); // 31.05
exports.onSampleResponses = onSampleResponses(); // 31.05
exports.onSampleRegisteredAccounts = onSampleRegisteredAccounts(); // 
exports.onSampleComments = onSampleComments();