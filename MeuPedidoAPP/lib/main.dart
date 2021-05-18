// import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/app_module.dart';
import 'app/app_widget.dart';

void main() {
  //
  print(' vai começar a aplicação ... issso é antes do runApp');
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ModularApp(module: AppModule(), child: AppWidget()));

  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) =>
  //     ModularApp(module: AppModule()),
  //   ),
  // );
}
