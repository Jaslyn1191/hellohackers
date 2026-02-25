import db from "./firebase-admin.js"; 
import admin from "firebase-admin";

export async function sendToPharmacist({ caseId }) {
  try {
    await db.collection("cases").update({
      status: "Pending Pharmacist Review",
      // create auto timestamp
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    // notifications
    const userMessage = "Okay, thank you. All the information you've provided will now be reviewed by a pharmacist."
    const pharmacistMessage = `New patient report ready for review:\nCase ID: ${caseId}\nIssue: ${userIssue}\nStatus: Pending`

    // successfully send to pharmacist
    return { success: true, userMessage };
  } catch (error) {
    console.error("Failed to send to pharmacist", error)
    return {
      success: false,
      error: error.message
    };
  }
}
