import db from "./firebase-admin.js";

export async function getPendingCases() {
  const snapshot = await db
    .collection("cases")
    .where("status", "==", "Pending Pharmacist Review")
    .get();

  if (snapshot.empty) return [];

  const pendingCases = [];

  snapshot.forEach(doc => {
    const data = doc.data();
    pendingCases.push({
      caseID: doc.id, 
      lastMessage: (data.conversation?.slice(-1)[0]?.content) || "Pending review by pharmacist",
      createdAt: data.createdAt ? data.createdAt.toDate().toISOString() : "",
      status: data.status || "Pending Pharmacist Review",
    });
  });


  return pendingCases;
}