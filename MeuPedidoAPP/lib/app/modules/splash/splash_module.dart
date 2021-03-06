import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => SplashPage(identificador: '')),
    ChildRoute('/lj/:identif',
        child: (_, args) => SplashPage(
              identificador: args.params['identif'],
            )),
  ];

  // static Inject get to => Inject<SplashModule>.of();
}
