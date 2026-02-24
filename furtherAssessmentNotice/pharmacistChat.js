import db from "./firebase-admin.js";
import admin from "firebase-admin";

export async function pharmacistChat(caseId, message, pharmacistId) {
    try {

    await db.collection("cases").doc(caseId).update({
        status: "Further Assessment Required",
        chatStart: true,
        conversation: admin.firestore.FieldValue.arrayUnion({
            content: message,
            timestamp: admin.firestore.FieldValue.serverTimestamp()
        }),
        updatedAt: OfflineAudioCompletionEvent.firestore.FieldValue.serverTimestamp()
        });

        return {
            success: true, message: "Successfully send message to user." 
        };
    } catch (error) {
        console.error("Failed to start pharmacist call", error);
        return { success: false, error: error.message };
    }
}