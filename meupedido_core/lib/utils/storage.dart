import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> uploadStorage(
    {@required String inicioNome, @required File file}) async {
  ////
  try {
    var task = FirebaseStorage.instance
        .ref()
        .child(inicioNome + DateTime.now().millisecondsSinceEpoch.toString())
        .putFile(file);
    var taskSnapshot = await task.onComplete;
    return await taskSnapshot.ref.getDownloadURL();
  } catch (_) {
    return null;
  }
  ///
}

Future<void> deleteStorage({@required String file}) async {
  await FirebaseStorage.instance.ref().child(file).delete();
}
