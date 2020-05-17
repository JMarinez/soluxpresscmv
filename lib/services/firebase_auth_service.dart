import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

@immutable
class User {
  final String uid;
  final String email;
  final String displayName;
  final String phoneNumber;
  final String address;

  User({
    @required this.uid,
    this.email,
    this.displayName,
    this.phoneNumber,
    this.address,
  });
}

class FirebaseAuthService {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }

    return User(
      uid: user.uid,
      displayName: user.displayName,
      phoneNumber: user.phoneNumber,
    );
  }

  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return _userFromFirebase(authResult.user);
  }

  Future<User> createUserWithEmailPassword(String email, String password) async {
    final AuthResult authResult = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    try {
      await authResult.user.sendEmailVerification();
    } catch (e) {
      print(e);
    }
    return _userFromFirebase(authResult.user);
  }

  Future<User> currentUser() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  Future signOut() {
    return _firebaseAuth.signOut();
  }
}
