import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();

export function onFirstSignIn() {
    return functions
        .region('europe-west1')
        .auth.user()
        .onCreate(async (user, context) => {

            const provider: admin.auth.UserInfo[]  =  user.providerData;
            if(provider[0].providerId === "facebook.com"
            || provider[0].providerId === "google.com"){
                await firestore.runTransaction(async (tx) => {
                    const accountRef = firestore.doc('account/' + user.uid);
                    return tx.create(accountRef, {
                        accountId: user.uid,
                        accountPictureUrl: user.photoURL,
                        name: user.displayName,
                        nameLowerCase: user.displayName.toLocaleLowerCase(),
                        friendCount: 0,
                        bio: "",
                        nickname: "",
                        goalsCreated: 0,
                        goalsCompleted: 0,
                        postsCreated: 0,
                        socialPoints: 0,
                        activityPoints: 0,
                        creativityPoints: 0,
                        created: admin.firestore.Timestamp.now()
                    });
                })
            }
        });
} 