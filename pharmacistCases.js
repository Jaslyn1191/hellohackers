import db from "./firebase-admin.js";
// import admin from "firebase-admin";

export async function getUserPendingCases() {
    // get the cases that fulfil both conditions
    const cases = await db.collection("cases").where("status", "Pending pharmacist").get();

    const userPendingCases =[];
    userCases.forEach(doc => {
        userPendingCases.push({ caseId: doc.id });
    });
    return userPendingCases;

}