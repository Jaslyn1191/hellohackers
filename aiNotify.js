// import db from "./firebase-admin.js"; 
import admin from "firebase-admin";

export async function sendToPharmacist({ caseId, userIssue }) {
  try {
    await db.collection("user_report").add({
      caseId,
      userIssue,
      status: "pending",
      // create auto timestamp
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    // notifications
    const userMessage = "Okay, thank you. All the information you've provided will now be reviewed by a pharmacist."
    const pharmacistMessage = `New patient report ready for review:\nCase ID: ${caseId}\nIssue: ${userIssue}\nStatus: Pending`

    // successfully send to pharmacist
    return { success: true, userMessage, pharmacistMessage };
  } catch (error) {
    console.error("Failed to send to pharmacist", error)
  }
}
