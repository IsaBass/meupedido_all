
import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => SplashPage(identificador: '')),
        //Router('/lj/:identif', child: (_, args) => SplashPage(identificador: args.params['identif'],)),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
