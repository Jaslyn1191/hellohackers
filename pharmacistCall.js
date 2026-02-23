import db from "./firebase-admin.js";

export async function pharmacistCall(caseId) {
    // update status to pharmacist call
    await db.collection("cases").doc(caseId).update({
        status: "Pharmacist Call",
        callRequired:true
    });
}