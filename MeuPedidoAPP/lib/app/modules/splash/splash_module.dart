import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routers => [
        ModuleRoute('/', child: (_, args) => SplashPage(identificador: '')),
        ModuleRoute('/lj/:identif',
            child: (_, args) => SplashPage(
                  identificador: args.params['identif'],
                )),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
