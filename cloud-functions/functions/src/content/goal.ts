import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();


export function updateGoalAccomplished() {
    return functions
        .region('europe-west1')
        .firestore
        .document('account/{accountId}/goals/{goalId}')
        .onUpdate(async (change, context) => {
            if (change.after !== change.before) {
                const accountId = context.params.accountId;
                const accountRef = firestore.doc('account/' + accountId);
                const goalColRef = firestore.collection('account/' + accountId + '/goals');
                const querySnapshot = await goalColRef.where('state', '==', 'completed').get();
                const goalCount = querySnapshot.size;
                console.log("Number of completed goals: " + goalCount);

                return accountRef.update({ 'goalsCompleted': goalCount });
            }
            return null;

        });
}

async function updateGoalCount(snapshot: FirebaseFirestore.DocumentSnapshot, context: functions.EventContext) {
    const accountRef = firestore.doc('account/' + context.params.accountId);
    const goalColRef = firestore.collection('account/' + context.params.accountId + '/goals');
    const querySnapshot = await goalColRef.get();
    const goalCount = querySnapshot.size;
    return accountRef.update({ 'goalsCreated': goalCount });
}

export function onGoalAdded() {
    return functions
        .region('europe-west1')
        .firestore
        .document('account/{accountId}/goals/{goalId}')
        .onCreate(async (snapshot, context) => {
            return updateGoalCount(snapshot, context);
        })
}

export function onGoalRemoved() {
    return functions
    .region('europe-west1')
    .firestore
        .document('account/{accountId}/goals/{goalId}')
        .onDelete(async (snapshot, context) => {
            return updateGoalCount(snapshot, context);
        })
}

export function onAddDefaultGoal() {
    return functions
    .region('europe-west1')
    .firestore
        .document('account/{accountId}')
        .onCreate(async (snapshot, context) => {
            const data = snapshot.data();
            await firestore.doc('account/' + data.accountId + "/goals/default-goal").set({
                    account: {
                        accountId: data.accountId,
                        name: data.name,
                        accountPictureUrl: data.accountPictureUrl
                    },
                    active: false,
                    category: "Other",
                    title: "TV habits",
                    description: "Log your TV viewing habits over the next week or two, log an estimate of the hours spent watching TV during the day.\nNote: this goal is private, so posts won't be shown to anybody but you, and data you log is always private.",
                    goalId: "default-goal",
                    public: false,
                    state: "newGoal",
                    logOptions: {
                        dailyCheckIn: true,
                        duration: false,
                        measurement:true,
                        measurementUnit: "Hours",
                        performance: false,
                        reflectiveNotes:true,
                    }
                });
        })
}