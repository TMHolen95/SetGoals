import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';

import { sendMessage } from "../notifications";
import { NotificationType, PointType } from "../enums";
import { rewardPoints } from "../systems/point-system";

export function onDataLogging() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/account/{accountId}/goals/{goalId}/logEntries/{logEntryId}')
        .onCreate(async (snapshot, context) => {
            const id = snapshot.ref.parent.parent.parent.parent.id
            /* console.log("onDataLogging: Id - " + id); */
            await rewardPoints(id, PointType.Activity, 3, null);
        });
    }