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
    final reference = FirebaseFirestore.instance.doc(path);

    await reference.set(profileReference.toMap());
  }

  Stream<ProfileReference> userProfileStream(String userUid) {
    final path = FirestorePath.profile(userUid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();

    return snapshots
        .map((snapshot) => ProfileReference.fromMap(snapshot.data()));
  }

  Future setService(String userUid, ExpService service) async {
    final serviceMap = service.toMap();

    final path = FirestorePath.services(userUid);
    final reference = FirebaseFirestore.instance.collection(path);
    await reference.add(serviceMap);
  }

  Future<DocumentSnapshot> getUserProfile(User user) async {
    final path = FirestorePath.profile(user.uid);
    final document = FirebaseFirestore.instance.doc(path);

    final profile = await document.get();

    if (profile.exists) {
      return profile;
    } else {
      final duration = Duration(seconds: 6);
      return Future.delayed(duration, () async {
        final profile = await document.get();

        String displayName = profile['displayName'];

        await user.updateProfile(displayName: displayName);
        await user.reload();

        return profile;
      });
    }
  }

  Future<User> updateDisplayName(
      BuildContext context, DocumentSnapshot userProfile) async {
    final user = Provider.of<FirebaseAuthService>(context, listen: false);

    final currentUser = user.currentUser();

    if (currentUser.displayName == null) {
      String displayName = userProfile['displayName'];
      await currentUser.updateProfile(displayName: displayName);
      return currentUser;
    }

    return currentUser;
  }

  Stream<List<ExpService>> serviceListStream(String userUid) {
    final path = FirestorePath.services(userUid);
    final reference = FirebaseFirestore.instance.collection(path).where(
        'status',
        whereIn: [Status.sent.index, Status.in_progress.index]);
    final data = reference.snapshots().map((snapshot) => snapshot.docs
        .map((document) => ExpService.fromMap(document.data(), document.id))
        .toList());
    return data;
  }

  Stream<List<ExpService>> masterServiceListStream(int serviceType) {
    final reference = FirebaseFirestore.instance
        .collectionGroup('services')
        .where('serviceType', isEqualTo: serviceType);
    final data = reference.snapshots().map((snapshot) => snapshot.docs
        .map((document) => ExpService.fromMap(document.data(), document.id))
        .toList());
    return data;
  }

  Future updateServiceStatus(ExpService service, double newStatus) async {
    final reference = FirebaseFirestore.instance
        .doc(FirestorePath.service(service.userUid, service.uid));
    service.updateStatus(newStatus.toInt());
    await reference.set(service.toMap());
  }
}
