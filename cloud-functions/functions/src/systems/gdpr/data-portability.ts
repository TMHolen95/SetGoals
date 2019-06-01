import * as admin from 'firebase-admin';
import * as functions from 'firebase-functions';
const firestore = admin.firestore();
const storage = admin.storage();

/* import * as archiver from 'archiver';
import * as fs from 'fs'; */



// TODO handle request all data stored on the user
/* export const onUserRequestPersonalData = functions.firestore
    .document('/account/{accountId}/personalDataRequests/{personalDataRequestsId}')
    .onCreate(async (snapshot, context) => {
        //const files: s.File[] = await storage.bucket('user/' + context.auth.uid).getFiles();

        const output: fs.WriteStream = fs.createWriteStream('target.zip');
        const archive: archiver.Archiver = archiver('zip');

        output.on('close', function () {
            console.log(archive.pointer() + ' total bytes');
            console.log('archiver has been finalized and the output file descriptor has closed.');
        });

        archive.on('error', function (err) {
            throw err;
        });

        archive.pipe(output);

        const dir: string = 'user/' + context.auth.uid;
        const dest: string = 'user/' + context.auth.uid + '/zip';
        archive.directory(dir, dest);

        archive.finalize();
    }); */