import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
// import 'package:get/get.dart';
import 'package:meupedido_core/core/constantes.dart';

import 'app_controller.dart';

class AppWidget extends StatelessWidget {
  //
  // final AppController _appController = Modular.get<AppController>();

  @override
  Widget build(BuildContext context) {
    print(' app_widget.dart >> esse é antes do MaterialAPP ');

    // return Observer(builder: (_) {
    return Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: kIsWeb
              ? MyConst.boxConstraints
              : BoxConstraints(maxWidth: double.infinity, minWidth: 0),
          child: MaterialApp(
            // home: HomePage(),
            //navigatorKey: Modular.navigatorDelegate,
            debugShowCheckedModeBanner: false,
            title: 'Meu Pedido',
            // theme: _appController.getTheme,
            // theme: ThemeData(
            //   primaryColor: Colors.red,
            //   accentColor: Colors.red,
            //   bottomAppBarColor: Colors.yellowAccent,
            // ),

            initialRoute: '/home',
            // onGenerateRoute: Modular,
            localizationsDelegates: [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            supportedLocales: [const Locale('pt', 'BR')],
          ).modular(),
        ));
    // });
  }
}

/*
Align(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: MyConst.boxConstraints,
              child:

*/
