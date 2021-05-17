import 'package:flutter_modular/flutter_modular.dart';

import 'login.cadastro.google_page.dart';
import 'login.cadastro_page.dart';
import 'login.reset_page.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        // Bind((i) => LoginController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => LoginPage()),
        ModularRouter('/cadastro', child: (_, args) => LoginCadastroPage()),
        ModularRouter('/cadastrogoogle',
            child: (_, args) => LoginCadastroGooglePage()),
        ModularRouter('/reset', child: (_, args) => LoginResetPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
