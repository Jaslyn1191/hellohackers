import db from "../firebase-admin.js";
import admin from "firebase-admin";

// Ai summary & Ai suggestion
export async function aiAssessment(caseId) {
    const caseRef = db.collection("cases").doc(caseId);
    const caseFound = await caseRef.get();

    if (!caseFound.exists) {
        throw new Error("Case not detected.");
    }

    const { userSymptoms = [] } = caseFound.data();

    if (userSymptoms.length === 0 ) {
        throw new Error("No symptoms to analyze.");
    }

    const symptomSummary = userSymptoms.map(s => '')
}