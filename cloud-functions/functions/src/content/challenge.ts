import * as functions from 'firebase-functions';

import { PointType } from "../enums";
import { rewardPoints } from "../systems/point-system";

export function onNewChallenge() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/challenge/{challengeId}')
        .onCreate(async (snapshot, context) => {
            const data = snapshot.data();
            if (data !== undefined) {
                const accountId = data.creatorId;
                await rewardPoints(accountId, PointType.Creativity, 5, null);
                // TODO reward extra points for like on challenge , minus points for dislike.
            }

        })
}

export function onDeleteChallenge() {
    return functions
        .region('europe-west1')
        .firestore
        .document('/challenge/{challengeId}')
        .onDelete(async (snapshot, context) => {
            const data = snapshot.data();

            if (data !== undefined) {
                const accountId = data.creatorId;
                await rewardPoints(accountId, PointType.Creativity, -5, null);
            }


        })
}

