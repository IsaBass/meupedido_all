import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:meupedido_core/core/constantes.dart';

import 'app_controller.dart';
import 'app_module.dart';

class AppWidget extends StatelessWidget {
  //
  final AppController _appController = AppModule.to.get<AppController>();

  @override
  Widget build(BuildContext context) {
    print(' app_widget.dart >> esse é antes do MaterialAPP ');

    return Observer(builder: (_) {
      return Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: kIsWeb
                ? MyConst.boxConstraints
                : BoxConstraints(maxWidth: double.infinity, minWidth: 0),
            child: GetMaterialApp(
              // home: HomePage(),
              navigatorKey: Modular.navigatorKey,
              debugShowCheckedModeBanner: false,
              title: 'Meu Pedido',
              theme: _appController.getTheme,
              // theme: ThemeData(
              //   primaryColor: Colors.red,
              //   accentColor: Colors.red,
              //   bottomAppBarColor: Colors.yellowAccent,
              // ),

              initialRoute: '/',
              onGenerateRoute: Modular.generateRoute,
              localizationsDelegates: [
                GlobalCupertinoLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: [const Locale('pt', 'BR')],
            ),
          ));
    });
  }
}

/*
Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: MyConst.boxConstraints,
              child:

*/
