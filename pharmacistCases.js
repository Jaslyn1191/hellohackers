import db from "./firebase-admin.js";
import admin from "firebase-admin";

export async function getUserPendingCases() {
    // get the cases that fulfil both conditions
    const userCases = await db.collection("cases").where("status", "Pending").get();

    const userPendingCases =[];
    userCases.forEach(doc => {
        userPendingCases.push({ caseId: doc.id });
    });
    return userPendingCases;

}

export async function reviewCase(caseId, decision) {
    if (!["approved", "furtherAssessment"].includes(decision)) {
    throw new Error("Invalid decision.");
  }
}