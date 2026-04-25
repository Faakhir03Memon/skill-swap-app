import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user stream
  Stream<User?> get userStream => _auth.authStateChanges();

  // Sign up
  Future<AppUser?> signUpWithEmail(String name, String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user != null) {
        // Create user document in Firestore
        AppUser newUser = AppUser(
          uid: user.uid,
          name: name,
          email: email,
          skills: [],
          points: 0,
          role: 'user', // Default role
          createdAt: DateTime.now(),
        );

        await _firestore.collection('users').doc(user.uid).set(newUser.toMap());
        return newUser;
      }
    } catch (e) {
      print('Sign Up Error: \$e');
      rethrow;
    }
    return null;
  }

  // Log in
  Future<AppUser?> loginWithEmail(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = credential.user;
      if (user != null) {
        return await getUserDetails(user.uid);
      }
    } catch (e) {
      print('Login Error: \$e');
      rethrow;
    }
    return null;
  }

  // Get User Details
  Future<AppUser?> getUserDetails(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        return AppUser.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print('Get User Error: \$e');
    }
    return null;
  }

  // Log out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
