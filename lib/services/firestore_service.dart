import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marinez_demo/models/profile_reference.dart';
import 'package:marinez_demo/services/firestore_path.dart';

class FirestoreService {
  final String userUid;

  FirestoreService({this.userUid});

  Future setUserProfile(ProfileReference profileReference) async {
    final path = FirestorePath.profile(userUid);
    final reference = Firestore.instance.document(path);
    
    await reference.setData(profileReference.toMap());
  }

  Stream<ProfileReference> userProfileStream() {
    final path = FirestorePath.profile(userUid);
    final reference = Firestore.instance.document(path);
    final snapshots = reference.snapshots();

    return snapshots.map((snapshot) => ProfileReference.fromMap(snapshot.data));
  }
}
