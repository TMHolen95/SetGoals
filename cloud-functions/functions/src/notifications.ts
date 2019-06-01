import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();

export async function sendMessage(receiverId: string, title: string, body: string, type: string, accountId: string, documentRef: string) {
    const accountFcm = (await firestore.doc('account/' + receiverId + '/fcm/fcms').get()).data();
    accountFcm['fcms'].forEach(async (fcm: string) => {
        console.log("FCM token retrieved: " + fcm);
        const message = createMessage(title, body, fcm, type, accountId, documentRef);
        await sendFirebaseCloudMessage(message);
    });
}

// Type is either null (A generic notification message), Comment, FriendRequestReceived, or FriendRequestAccepted. more may come. 
function createMessage(title: string, body: string, fcm: string, type: string, accountId: string, documentRef: string) {
    return {
        token: fcm,
        data: {
            click_action: "FLUTTER_NOTIFICATION_CLICK",
            type: type,
            accountId: accountId,
            documentRef: documentRef
        },
        android: {
            notification: {
                title: title,
                body: body,
                sound: "default"
            }
        },
        apns: {
            payload: {
                aps: {
                    alert: {
                        title: title,
                        body: body
                    },
                    sound: "default",
                    badge: 1
                }
            }
        }
    };
}

async function sendFirebaseCloudMessage(message: admin.messaging.Message) {
    admin.messaging().send(message)
        .then((response: any) => {
            // Response is a message ID string.
            console.log('Successfully sent message:', response);
        })
        .catch((error: any) => {
            console.log('Error sending message:', error);
        });
};
