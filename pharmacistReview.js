import db from "./firebase-admin.js";

export async function getUserPendingCases() {
  const cases = await db.collection("cases")
    .where("status", "Pending Pharmacist Review")
    .get();

  const userCases = [];
  cases.forEach(doc => {
    pendingCases.push({ caseId: doc.id });
  });

  return pendingCases;
}