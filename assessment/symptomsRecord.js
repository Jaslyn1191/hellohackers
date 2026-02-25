import db from "../firebase-admin.js";
import admin from "firebase-admin";

export async function recordSymptoms(caseId, message) {
    await db.collection("cases").doc(caseId).update({
        userSymptoms: admin.firestore.FieldValue.arrayUnion({
            role: "user",
            content: message,
            timestamp:admin.firebstore.FieldValue.serverTimestamp()
        }),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });
}