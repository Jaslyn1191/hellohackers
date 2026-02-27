import 'package:cloud_firestore/cloud_firestore.dart';
import 'case_id_gen.dart';

class ChatService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create a new case
  static Future<String> createCase({
    required String userEmail,
    required String caseId, // Optional, can be generated if not provided
  }) async {
    // final generatedCaseId = await CaseService.generateCaseId();

    final docRef = _db.collection("cases").doc(); // access the document

     // Create case document
    await docRef.set({
      "caseID": caseId,
      'userEmail': userEmail,
      'status': 'Pending Pharmacist Review',
      'createdAt': FieldValue.serverTimestamp(),
    });

    // return caseId; // to be used for chat page/side panel
  }

  /// ---------------------------
  /// Add message to a case
  /// ---------------------------
  static Future<void> addMessage({
    required String caseId,
    required String text,
    required bool isUser,
  }) async {
    final query = await _db.collection('cases').where('caseID', isEqualTo: caseId).limit(1).get();

    if (query.docs.isEmpty) return;

    // final caseRef = _db.collection('cases').doc(caseId);
    final caseRef =query.docs.first.reference;

    await caseRef.collection('messages').add({
      'text': text,
      'isUser': isUser,
      'timestamp': FieldValue.serverTimestamp(),
    });

    // Update last message preview
    await caseRef.update({
      'lastMessage': text,
    });
  }

  /// ---------------------------
  /// Get all cases for a user (Sidebar)
  /// ---------------------------
  static Stream<QuerySnapshot> getUserCases(String userEmail) {
    return _db
        .collection('cases')
        .where('userEmail', isEqualTo: userEmail)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// ---------------------------
  /// Get messages of a case
  /// ---------------------------
  static Stream<QuerySnapshot> getCaseMessages(String caseId) {
    return _db
        .collection('cases')
        .doc(caseId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots();
  }

  /// ---------------------------
  /// Update case status (Admin)
  /// ---------------------------
  static Future<void> updateCaseStatus({
    required String caseId,
    required String status,
  }) async {
    await _db.collection('cases').doc(caseId).update({
      'status': status,
    });
  }

  /// ---------------------------
  /// Delete case (Optional)
  /// ---------------------------
  // static Future<void> deleteCase(String caseId) async {
  //   // Delete messages first (optional cleanup)
  //   final messages = await _db
  //       .collection('cases')
  //       .doc(caseId)
  //       .collection('messages')
  //       .get();

  //   for (var doc in messages.docs) {
  //     await doc.reference.delete();
  //   }

  //   // Delete case document
  //   await _db.collection('cases').doc(caseId).delete();
  // }
}