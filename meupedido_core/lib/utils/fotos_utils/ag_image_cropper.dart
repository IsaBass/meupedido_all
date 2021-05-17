import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File> agImageCropper(String imagePath) async {
  ///
  File croppedFile = await ImageCropper.cropImage(
    sourcePath: imagePath,
    aspectRatioPresets: [
      CropAspectRatioPreset.square,
      CropAspectRatioPreset.ratio3x2,
      CropAspectRatioPreset.original,
      CropAspectRatioPreset.ratio4x3,
      CropAspectRatioPreset.ratio16x9
    ],
    androidUiSettings: AndroidUiSettings(
      toolbarTitle: 'Sua imagem',
      toolbarColor: Colors.deepOrange,
      toolbarWidgetColor: Colors.white,
      initAspectRatio: CropAspectRatioPreset.ratio16x9,
      lockAspectRatio: true,
    ),
    iosUiSettings: IOSUiSettings(
      minimumAspectRatio: 1.0,
    ),
  );

  return croppedFile;
  //
}
