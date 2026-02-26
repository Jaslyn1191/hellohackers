import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Create a new case
  static Future<void> createCase({
    required String caseId,
    required String userEmail,
  }) async {
    await _db.collection('cases').doc(caseId).set({
      'userEmail': userEmail,
      'status': 'pending', // default
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// ---------------------------
  /// Add message to a case
  /// ---------------------------
  static Future<void> addMessage({
    required String caseId,
    required String text,
    required bool isUser,
  }) async {
    final caseRef = _db.collection('cases').doc(caseId);

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
  static Stream<QuerySnapshot> getUserCases(String caseId) {
    return _db
        .collection('cases')
        .where('caseId', isEqualTo: caseId)
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
  static Future<void> deleteCase(String caseId) async {
    // Delete messages first (optional cleanup)
    final messages = await _db
        .collection('cases')
        .doc(caseId)
        .collection('messages')
        .get();

    for (var doc in messages.docs) {
      await doc.reference.delete();
    }

    // Delete case document
    await _db.collection('cases').doc(caseId).delete();
  }
}