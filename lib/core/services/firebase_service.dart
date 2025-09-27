import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();
  factory FirebaseService() => _instance;
  FirebaseService._internal();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => auth.currentUser;
  Stream<User?> get authStateChanges => auth.authStateChanges();

  Future<UserCredential> signIn(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> signUp(String email, String password) {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() => auth.signOut();

  // Firestore shortcuts
  CollectionReference getCollection(String path) => firestore.collection(path);
  DocumentReference getDocument(String path) => firestore.doc(path);
}
