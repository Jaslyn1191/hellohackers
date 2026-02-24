import db from "./firebase-admin.js";

export async function pharmacistCall(caseId) {
    try {
    
        // update status to pharmacist call
        await db.collection("cases").doc(caseId).update({
            status: "Further Assessment Required",
            callEnabled: true,
            callStatus: "ringing",
            updatedAt: admin.firestore.FieldValue.serverTimestamp()
        });

        // record the call timing in firebase
        await db.collection("calls").doc(caseId).set({
            caseId,
            status: "ringing",
            startedAt: admin.firestore.FieldValue.serverTimestamp()
            });

        return {
            success: true,
            message: "Pharmacist call initiated",
            caseId,
            callStatus: "ringing"
            };
            
        } catch (error) {
            console.error("Failed to start pharmacist call", error);
            return { success: false, error: error.message };
        }
}