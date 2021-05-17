import 'package:flutter_modular/flutter_modular.dart';

import 'login.cadastro.google_page.dart';
import 'login.cadastro_page.dart';
import 'login.reset_page.dart';
import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => LoginPage()),
        Router('/cadastro', child: (_, args) => LoginCadastroPage()),
        Router('/cadastrogoogle', child: (_, args) => LoginCadastroGooglePage()),
        Router('/reset', child: (_, args) => LoginResetPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
