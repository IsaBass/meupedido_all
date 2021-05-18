// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() async {
  //
  print(' vai começar a aplicação ... issso é antes do runApp');
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) =>
  //     ModularApp(module: AppModule()),
  //   ),
  // );
}
