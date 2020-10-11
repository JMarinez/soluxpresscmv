import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential authResult = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return authResult.user;
  }

  Future<User> createUserWithEmailPassword(
      String email, String password, String displayName) async {

    final UserCredential authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return authResult.user;
  }

  User currentUser() {
    return _firebaseAuth.currentUser;
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }
}
