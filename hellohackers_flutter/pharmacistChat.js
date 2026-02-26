import db from "./firebase-admin.js";
import admin from "firebase-admin";

export async function pharmacistChat(caseId, message) {
    try {

    await db.collection("cases").doc(caseId).update({
        status: "Further Assessment Required",
        chatStarted: true,
        conversation: admin.firestore.FieldValue.arrayUnion({
            role: "pharmacist",
            content: message,
            timestamp: admin.firestore.FieldValue.serverTimestamp()
        }),
        updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });

        return {
            success: true, message: "Successfully send message to user." 
        };
    } catch (error) {
        console.error("Failed to start pharmacist call", error);
        return { success: false, error: error.message };
    }
}