// Just used for testing various code with "ts-node playground-file.ts" in
// "augmented_goals\cloud\functions\src"

import {admin, fsImp} from "./firestore";

function lastWeek() {
    const today = new Date();
    
    const weeklySeconds = 60*60*24*7 * 1000; // * 1000 since we are not interested in milliseconds.
    const weekAgo = new Date();
    weekAgo.setTime(today.valueOf() - weeklySeconds);

    // console.log('Today: ' + today.toLocaleString());
    // console.log('Week ago?: ' + weekAgo.toLocaleString());

    return fsImp.Timestamp.fromDate(weekAgo);
}

lastWeek();