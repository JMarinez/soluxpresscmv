import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<StorageTaskSnapshot> uploadImage(String path, File file) async {
    return await _firebaseStorage.ref().child(path).putFile(file).onComplete;
  }
}