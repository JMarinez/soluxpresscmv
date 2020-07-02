import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firebase_auth_service.dart';
import 'package:marinez_demo/services/firestore_path.dart';
import 'package:provider/provider.dart';

class FirestoreService {
  final String userUid;

  FirestoreService({this.userUid});

  Future setUserProfile(ProfileReference profileReference) async {
    final path = FirestorePath.profile(profileReference.userUid);
    final reference = Firestore.instance.document(path);

    await reference.setData(profileReference.toMap());
  }

  Stream<ProfileReference> userProfileStream(String userUid) {
    final path = FirestorePath.profile(userUid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => ProfileReference.fromMap(snapshot.data));
  }

  Future setService(String userUid, ExpService service) async {
    final path = FirestorePath.services(userUid);
    final reference = Firestore.instance.collection(path);

    await reference.add(service.toMap());
  }

  Future<DocumentSnapshot> getUserProfile(FirebaseUser user) async {
    final path = FirestorePath.profile(user.uid);
    final document = Firestore.instance.document(path);

    final profile = await document.get();

    if (profile.exists) {
      return profile;
    } else {
      final duration = Duration(seconds: 6);
      return Future.delayed(duration, () async {
        final profile = await document.get();

        final userInfo = UserUpdateInfo();
        userInfo.displayName = profile['displayName'];

        await user.updateProfile(userInfo);
        await user.reload();

        return profile;
      });
    }
  }

  Future<FirebaseUser> updateDisplayName(
      BuildContext context, DocumentSnapshot userProfile) async {
    final user = Provider.of<FirebaseAuthService>(context, listen: false);
    final userInfo = UserUpdateInfo();

    final currentUser = await user.currentUser();

    if (currentUser.displayName == null) {
      userInfo.displayName = userProfile['displayName'];

      await currentUser.updateProfile(userInfo);
      return currentUser;
    }

    return currentUser;
  }

  Stream<List<ExpService>> serviceListStream(String userUid, int status) {
    final path = FirestorePath.services(userUid);
    final reference = Firestore.instance.collection(path);
    final data = reference.snapshots().map((snapshot) => snapshot.documents
        .map((document) => ExpService.fromMap(document.data))
        .toList());
    return data;
  }

  Stream<ExpService> serviceDetailStream(String userUid, String serviceUid) {
    final path = FirestorePath.service(userUid, serviceUid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => ExpService.fromMap(snapshot.data));
  }
}
