import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirestoreService _instance = FirestoreService._();
  factory FirestoreService() => _instance;
  FirestoreService._();

  /// Create or Update document
  Future<void> setDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
    bool merge = true,
  }) async {
    await _firestore
        .collection(collectionPath)
        .doc(docId)
        .set(data, SetOptions(merge: merge));
  }

  /// Add a new document with auto-generated ID
  Future<DocumentReference<Map<String, dynamic>>> addDocument({
    required String collectionPath,
    required Map<String, dynamic> data,
  }) async {
    return await _firestore.collection(collectionPath).add(data);
  }

  /// Get a single document
  Future<DocumentSnapshot<Map<String, dynamic>>> getDocument({
    required String collectionPath,
    required String docId,
  }) async {
    return await _firestore.collection(collectionPath).doc(docId).get();
  }

  /// Listen to document changes (real-time)
  Stream<DocumentSnapshot<Map<String, dynamic>>> listenToDocument({
    required String collectionPath,
    required String docId,
  }) {
    return _firestore.collection(collectionPath).doc(docId).snapshots();
  }

  /// Get all documents in a collection
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getCollection({
    required String collectionPath,
  }) async {
    final querySnapshot = await _firestore.collection(collectionPath).get();
    return querySnapshot.docs;
  }

  /// Listen to collection changes (real-time)
  Stream<List<QueryDocumentSnapshot<Object?>>> listenToCollection({
    required String collectionPath,
    Query Function(Query query)? queryBuilder,
  }) {
    Query query = _firestore.collection(collectionPath);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    return query.snapshots().map((snapshot) => snapshot.docs);
  }

  /// Update specific fields in a document
  Future<void> updateDocument({
    required String collectionPath,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).update(data);
  }

  /// Delete a document
  Future<void> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    await _firestore.collection(collectionPath).doc(docId).delete();
  }
}
