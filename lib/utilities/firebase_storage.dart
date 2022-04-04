import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

FirebaseStorage storage = FirebaseStorage.instance;

final Reference storageRef = FirebaseStorage.instance.ref();

Future<String> uploadImage(File? image) async {
  Uuid uuid = const Uuid();

  String downloadUrl = "";
  String path = "eventImages/" + uuid.v4();

  try {
    if (image != null) {
      TaskSnapshot res = await storageRef.child(path).putFile(image);
      downloadUrl = res.ref.fullPath;
    }
  } on FirebaseException catch (e) {
    log("Firebase Storage Error", error: e);
  }

  return downloadUrl;
}
