import * as admin from 'firebase-admin';
const firestore = admin.firestore();
import { PointType } from "../enums";

export async function rewardPoints(accountId: String, pointType: PointType, points: number, batch: FirebaseFirestore.WriteBatch) {
    const accountRef = firestore.doc('account/' + accountId);
    const accountDoc = await accountRef.get();
    const data = accountDoc.data();

    function updateByBatchOrNot(jsonData) {
        if (batch !== null) {
            batch.update(accountRef, jsonData);
            return null;
        } else {
            return accountRef.update(jsonData);
        }
    }

    switch (pointType) {
        case PointType.Social:
            return updateByBatchOrNot({ 'socialPoints': data.socialPoints + points });
        case PointType.Activity:
            return updateByBatchOrNot({ 'activityPoints': data.activityPoints + points });
        case PointType.Creativity:
            return updateByBatchOrNot({ 'creativityPoints': data.creativityPoints + points });
    }
};
