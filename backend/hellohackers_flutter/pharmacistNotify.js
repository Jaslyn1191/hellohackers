import db from "./firebase-admin.js"; 
import admin from "firebase-admin";

export async function sendToPharmacist({ caseId }) {
  try {
    if (!caseId) {
      throw new Error("caseId is required");
    }

    const doc = await db.collection("cases").doc(caseId).get();
    if (!doc.exists) throw new Error("Case not found");

    const userIssue = doc.data().symptoms || "No issue provided";

    const pharmacistMessage = `New patient report ready for review:
    Case ID: ${caseId}
    Issue: ${userIssue}
    Status: Pending`;

    await db.collection("cases").doc(caseId).update({
      status: "Pending Pharmacist Review",
      // create auto timestamp
      createdAt: admin.firestore.FieldValue.serverTimestamp()
    });

    // notifications
    const userMessage = "Okay, thank you. All the information you've provided will now be reviewed by a pharmacist."

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
