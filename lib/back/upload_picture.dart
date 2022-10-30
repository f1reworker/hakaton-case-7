import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart';

Future<String?> uploadFile(String fileName, String filePath, String ref) async {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  File file = File(filePath);

  try {
    await storage.ref('$ref/$fileName').putFile(file);
    var a = await storage.ref('$ref/$fileName').getDownloadURL();
    return a;
  } on firebase_core.FirebaseException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}
