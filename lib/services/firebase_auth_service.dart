import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  Stream<FirebaseUser> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return authResult.user;
  }

  Future<FirebaseUser> createUserWithEmailPassword(
      String email, String password, String displayName) async {

    final AuthResult authResult = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    return authResult.user;
  }

  Future<FirebaseUser> currentUser() async {
    return await _firebaseAuth.currentUser();
  }

  Future signOut() async {
    return await _firebaseAuth.signOut();
  }
}
