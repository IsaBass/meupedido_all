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
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage()),
    ChildRoute('/cadastro', child: (_, args) => LoginCadastroPage()),
    ChildRoute('/cadastrogoogle',
        child: (_, args) => LoginCadastroGooglePage()),
    ChildRoute('/reset', child: (_, args) => LoginResetPage()),
  ];

  // static Inject get to => Inject<LoginModule>.of();
}
