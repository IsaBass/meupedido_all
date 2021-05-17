import 'package:flutter_modular/flutter_modular.dart';

import 'login.cadastro.google_page.dart';
import 'login.cadastro_page.dart';
import 'login.reset_page.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind((i) => LoginController()),
      ];

  @override
  List<ModularRoute> get routers => [
        ModuleRoute('/', child: (_, args) => LoginPage()),
        ModuleRoute('/cadastro', child: (_, args) => LoginCadastroPage()),
        ModuleRoute('/cadastrogoogle',
            child: (_, args) => LoginCadastroGooglePage()),
        ModuleRoute('/reset', child: (_, args) => LoginResetPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
