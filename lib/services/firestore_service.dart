import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marinez_demo/models/exp_service.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firestore_path.dart';

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
    final path = FirestorePath.service(userUid, service.uid);
    final reference = Firestore.instance.document(path);

    await reference.setData(service.toMap());
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
