import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
import { collectionAccountGoals } from '../../firestore';
import { DocumentSnapshot, QuerySnapshot, Timestamp } from '@google-cloud/firestore';
import { print, isRegExp } from 'util';
import { document } from 'firebase-functions/lib/providers/firestore';


const empty = "null";
const comma = ",";
const quote = '"';
function format(num: number) {
    return String((Math.round(num * 100) / 100).toFixed(2));
}

function retrieveGoalDocs(queriesAccounts: FirebaseFirestore.QuerySnapshot) {
    return retrieveCollection(queriesAccounts, "goals");
}

function retrievePostDocs(queriesAccounts: FirebaseFirestore.QuerySnapshot) {
    return retrieveCollection(queriesAccounts, "posts");
}

function retrieveReminderDocs(queriesAccounts: FirebaseFirestore.QuerySnapshot) {
    return retrieveCollection(queriesAccounts, "reminders");
}

function retrieveCollection(queriesAccounts: FirebaseFirestore.QuerySnapshot, subPath: string) {

    const collectionPromise: Promise<QuerySnapshot>[] = [];
    queriesAccounts.docs.forEach((doc) => {
        // Obtain number of user set goals.
        collectionPromise.push(admin.firestore().collection(doc.ref.path + "/" + subPath).get())

    });

    return collectionPromise;
}

// TODO if more retrievals use Promise<DocumentSnapshot> create a method to reduce duplicate code.
function retrieveBfiDocs(queriesAccounts: FirebaseFirestore.QuerySnapshot) {
    const bfiPromise: Promise<DocumentSnapshot>[] = [];

    queriesAccounts.docs.forEach((doc) => {
        // Obtain bfi.
        bfiPromise.push(admin.firestore().doc(doc.ref.path + "/questionnaire/bfi").get())
    });

    return bfiPromise;
}

function retrieveGoalLogEntriesDocs(goals: QuerySnapshot[], csv: string[]): Promise<QuerySnapshot>[] {

    const goalLogsPromise: Promise<QuerySnapshot>[] = [];
    goals.forEach((qs, i) => {
        qs.docs.forEach((doc, j) => {
            goalLogsPromise.push(admin.firestore().collection(doc.ref.path + "/logEntries").get())
        });
    });

    return goalLogsPromise;
}

function retrieveCommentDocs(posts: QuerySnapshot[], csv: string[]): Promise<QuerySnapshot>[] {

    const commentPromise: Promise<QuerySnapshot>[] = [];
    posts.forEach((qs, i) => {
        qs.docs.forEach((doc, j) => {
            commentPromise.push(admin.firestore().collection(doc.ref.path + "/comments").get())
        });
    });

    return commentPromise;
}

function writeBfiToCsv(bfiValues: DocumentSnapshot[], csv: string[]) {

    bfiValues.forEach((val, index) => {
        const bfi = val.data();
        let bfiCsv: string = val.ref.parent.parent.id + comma;

        if (bfi === undefined) {
            bfiCsv = bfiCsv
                + empty + comma
                + empty + comma
                + empty + comma
                + empty + comma
                + empty + comma;
        } else {
            bfiCsv = bfiCsv
                + bfi['Openness'] + comma
                + bfi["Conscientiousness"] + comma
                + bfi["Extraversion"] + comma
                + bfi["Agreeableness"] + comma
                + bfi["Neuroticism"] + comma;
        }

        console.log("BFI: " + bfiCsv);
        if (csv[index + 1] === undefined) {
            csv[index + 1] = "";
        }

        csv[index + 1] = csv[index + 1] + bfiCsv;
    });

    console.log('Sending csv:', csv);
    return csv;

}


function writeGoalsToCsv(goals: QuerySnapshot[]): string[] {
    // TODO append headers.
    console.log(comma);

    let csv: string[] = [];
    csv[0] = "accountId" + comma +
        "goalId" + comma +
        "active" + comma +
        "state" + comma +
        "public" + comma +
        "category" + comma +
        quote + "title" + quote + comma +
        quote + "description" + quote;

    let writeIndex = 1;

    // Loops through a array of QuerySnapshots, where each index is a user.
    goals.forEach((goal) => {
        // Loop through the goals for a user;
        if (!goal.empty) {
            goal.docs.forEach((g) => {
                const data = g.data();
                csv[writeIndex] = data['account']['accountId'] + comma +
                    data["goalId"] + comma +
                    data["active"] + comma +
                    data["state"] + comma +
                    data["public"] + comma +
                    data["category"] + comma +
                    quote + data["title"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                    quote + data["description"].replace(/(\r\n|\n|\r)/gm, " ") + quote;

                writeIndex++;
            });
        }
    })
    return csv;
}

function writePostsToCsv(posts: QuerySnapshot[]): string[] {
    // TODO append headers.

    let csv: string[] = [];
    csv[0] = "accountId" + comma +
        "postId" + comma +

        "goalId" + comma +
        "active" + comma +
        "state" + comma +
        "public" + comma +
        "category" + comma +
         "goalTitle" +  comma +
         "description" +  comma +

        "width" + comma +
        "height" + comma +
        "message" + comma +
        "postTitle" + comma +
        "timestamp" + comma +

        "filename"
        ;

    let writeIndex = 1;

    // Loops through a array of QuerySnapshots, where each index is a user.
    posts.forEach((post) => {

        if (!post.empty) {
            post.docs.forEach((g) => {
                const postData = g.data();
                const goalData = postData["goal"];
                const created: Timestamp = postData["timestamp"];
                csv[writeIndex] = goalData['account']['accountId'] + comma +
                    postData["postId"] + comma +
                    goalData["goalId"] + comma +
                    goalData["active"] + comma +
                    goalData["state"] + comma +
                    goalData["public"] + comma +
                    goalData["category"] + comma +
                    quote + goalData["title"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                    quote + goalData["description"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                    postData["width"] + comma +
                    postData["height"] + comma +
                    quote + postData["message"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                    quote + postData["title"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                    created.toMillis() + comma +
                    postData["fileName"];

                writeIndex++;
            });
        }
    })
    return csv;
}


function writeLogEntriesToCsv(logEntries: QuerySnapshot[], csv: string[]) {
    logEntries.forEach((qs, i) => {
        console.log("Docs in query snapshot: " + qs.docs.length.toString());

        qs.docs.forEach((doc, j) => {
            const index: number = 1 + i * j;
            const log = doc.data();

            const timeCreated: FirebaseFirestore.Timestamp = log["timestamp"];

            csv[index] = doc.ref.parent.parent.parent.parent.id + comma + // Account id
                doc.ref.parent.parent.id + comma + // Goal id
                log["entryId"] + comma +
                log["dailyCheckIn"] + comma +
                log["duration"] + comma +
                log["measurement"] + comma +
                log["measurementUnit"] + comma +
                log["performance"] + comma +
                log["reflectiveNotes"] + comma +
                timeCreated.toDate().toString() + comma;

        });
    });

}

function writeCommentsToCsv(logEntries: QuerySnapshot[], csv: string[]) {
    logEntries.forEach((qs, i) => {
        console.log("Docs in query snapshot: " + qs.docs.length.toString());

        qs.docs.forEach((doc, j) => {
            const index: number = 1 + i * j;
            const log = doc.data();

            const timeCreated: FirebaseFirestore.Timestamp = log["timestamp"];

            csv[index] = log["account"]["accountId"] + comma + // Account id
                doc.ref.parent.parent.id + comma + // Post id
                log["commentId"] + comma +
                quote + log["message"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                timeCreated.toDate().toString() + comma;

        });
    });
}

function writeRemindersToCsv(reminders: QuerySnapshot[], csv: string[]) {
    reminders.forEach((qs, i) => {
        console.log("Docs in query snapshot: " + qs.docs.length.toString());

        qs.docs.forEach((doc, j) => {
            const index: number = 1 + i * j;
            const reminder = doc.data();

            const timeToRemind: FirebaseFirestore.Timestamp = reminder["timeToRemind"];
            const timeCreated: FirebaseFirestore.Timestamp = reminder["timeCreated"];

            csv[index] = doc.ref.parent.parent.id + comma +
                reminder["canceled"] + comma +
                reminder["category"] + comma +
                reminder["type"] + comma +
                timeToRemind.toDate().toString() + comma +
                timeCreated.toDate().toString() + comma +
                reminder["goalId"];
        });
    });
}

function csvResponse(csv: string[]) {
    let response: string = "";
    csv.forEach(str => {
        response = response + str + "\n";
    })
    return response;
}

export function onSampleAccounts() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            let csv: string[] = ["accountId" + comma +
                "openness" + comma +
                "conscientiousness" + comma +
                "extroversion" + comma +
                "agreeableness" + comma +
                "neuroticism" + comma +
                "friends" + comma +
                "socialPoints" + comma +
                "creativityPoints" + comma +
                "actionPoints"];


            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const bfiPromise: Promise<DocumentSnapshot>[] = retrieveBfiDocs(queriesAccounts);


            // Handle bfi's first
            Promise.all(bfiPromise).then((values) => {
                writeBfiToCsv(values, csv);
                queriesAccounts.docs.forEach((doc, i) => {
                    csv[i + 1] += doc.data()["friendCount"] + comma +
                        doc.data()["socialPoints"] + comma +
                        doc.data()["creativityPoints"] + comma +
                        doc.data()["activityPoints"]
                });

                const response: string = csvResponse(csv);
                res.status(200).send(response);
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSampleGoals() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const goalPromise: Promise<QuerySnapshot>[] = retrieveGoalDocs(queriesAccounts);
            // Handle Goals
            Promise.all(goalPromise).then((goalValues) => {
                console.log("GoalValues Length:" + goalValues.length);

                const csv: string[] = writeGoalsToCsv(goalValues)
                const response: string = csvResponse(csv);
                res.status(200).send(response);
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSampleReminders() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const reminderPromise: Promise<QuerySnapshot>[] = retrieveReminderDocs(queriesAccounts);

            // Handle Goals
            Promise.all(reminderPromise).then((reminderValues) => {
                const headers: string = "accountId" + comma + "canceled" + comma + "category" + comma + "type" + comma + "timeToRemind" + comma + "timeCreated" + comma + "goalId";
                const reminderCsv: string[] = [headers];
                //Writes necessary data from the goals first.
                writeRemindersToCsv(reminderValues, reminderCsv);
                const response: string = csvResponse(reminderCsv);
                res.status(200).send(response);
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSampleGoalLogEntries() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const goalPromise: Promise<QuerySnapshot>[] = retrieveGoalDocs(queriesAccounts);

            // Handle Goals
            Promise.all(goalPromise).then((goalValues) => {
                const headers: string = "accountId" + comma +
                    "goalId" + comma +
                    "entryId" + comma +
                    "dailyCheckIn" + comma +
                    "duration" + comma +
                    "measurement" + comma +
                    "measurementUnit" + comma +
                    "performance" + comma +
                    "reflectiveNotes" + comma +
                    "timestamp" + comma;

                const logsCsv: string[] = [headers];
                //Writes necessary data from the goals first.
                const logEntriesPromise: Promise<QuerySnapshot>[] = retrieveGoalLogEntriesDocs(goalValues, logsCsv);
                Promise.all(logEntriesPromise).then((logEntries) => {
                    // Writes remaining data in the log entries.
                    writeLogEntriesToCsv(logEntries, logsCsv);
                    const response: string = csvResponse(logsCsv);
                    res.status(200).send(response);
                }).catch((error) => {
                    console.log(error);
                    res.status(500).send(error);
                });
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSampleComments() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const postPromise: Promise<QuerySnapshot>[] = retrievePostDocs(queriesAccounts);

            // Handle Goals
            Promise.all(postPromise).then((postValues) => {
                const headers: string = "accountId" + comma +
                    "postId" + comma +
                    "commentId" + comma +
                    "message" + comma +
                    "timestamp" + comma;

                const logsCsv: string[] = [headers];
                //Writes necessary data from the goals first.
                const commentPromise: Promise<QuerySnapshot>[] = retrieveCommentDocs(postValues, logsCsv);
                Promise.all(commentPromise).then((logEntries) => {
                    // Writes remaining data in the log entries.
                    writeCommentsToCsv(logEntries, logsCsv);
                    const response: string = csvResponse(logsCsv);
                    res.status(200).send(response);
                }).catch((error) => {
                    console.log(error);
                    res.status(500).send(error);
                });
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSamplePosts() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            // Write title row.
            const queriesAccounts: FirebaseFirestore.QuerySnapshot = await admin.firestore().collection('account').get();
            const postPromise: Promise<QuerySnapshot>[] = retrievePostDocs(queriesAccounts);
            // Handle Goals
            Promise.all(postPromise).then((postValues) => {
                console.log("PostValues Length:" + postValues.length);

                const csv: string[] = writePostsToCsv(postValues)
                const response: string = csvResponse(csv);
                res.status(200).send(response);
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });
        });
}

export function onSampleResponses() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {
            const quiz = admin.firestore().collection("quiz");

            var quizResponses = Promise.all([
                quiz.doc('General').collection('responses').get(),
                quiz.doc('Social').collection('responses').get(),
                quiz.doc('logging').collection('responses').get(),
                quiz.doc('map').collection('responses').get(),
                quiz.doc('pricacy').collection('responses').get(), // (There is a typo on the DB)
                quiz.doc('xFeedback').collection('responses').get()
            ]);

            let csv: string[] = ["accountId,question,freeText,likertPoints,labels,score,filename"];
            quizResponses.then((queries) => { // QuerySnapshots from the promise.
                queries.forEach((qs) => {  // Loop through the QuerySnapshots.
                    qs.docs.forEach((ds) => { // Loop through the quiz respondents.
                        const data = ds.data();
                        const questions = data["questions"];

                        questions.forEach((qst) => { // Loop through the questions in the quiz
                            const newLabels = [];
                            qst["labels"].forEach((label) => {
                                newLabels[newLabels.length] = label.replace(/(\r\n|\n|\r)/gm, " ");
                            })

                            csv[csv.length] = data["accountId"] + comma +
                                quote + qst["question"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                                quote + qst["freeText"].replace(/(\r\n|\n|\r)/gm, " ") + quote + comma +
                                qst["likertPoints"] + comma +
                                quote + newLabels.toString() + quote + comma +
                                qst["score"] + comma +
                                qst["fileName"];
                        })

                    });
                });
                const response: string = csvResponse(csv);
                res.status(200).send(response);
            }).catch((error) => {
                console.log(error);
                res.status(500).send(error);
            });


        });
}

export function onSampleRegisteredAccounts() {
    return functions
        .region('europe-west1')
        .https
        .onRequest(async (req, res) => {

            const csv: string[] = ["accountId,creationTime,readableCreationTime,provider"];
            const promisedUsers: Promise<admin.auth.ListUsersResult> = admin.auth().listUsers();
            promisedUsers.then((result) => {
                result.users.forEach((user) => {

                    let providers = "";
                    user.providerData.forEach((item: admin.auth.UserInfo) => {
                        providers += item.providerId;
                    });
                    const timeCreated:number = Date.parse(user.metadata.creationTime);
                    
                    csv[csv.length] = user.uid + comma +
                        timeCreated + comma +
                        quote + user.metadata.creationTime + quote + comma +
                        providers;
                })
                const response = csvResponse(csv);
                res.status(200).send(response);
            }).catch((error) => {
                res.status(500).send(error);
            })


        })
};