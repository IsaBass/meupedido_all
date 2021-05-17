
import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'configs_controller.dart';
import 'configs_page.dart';
import 'empresas/empresas_module.dart';
import 'usuarios/usuarios_module.dart';

class ConfigsModule extends ChildModule {
  @override
  List<Bind> get binds => [
       
        Bind((i) => ConfigsController(
            AppModule.to.get<AuthController>(), AppModule.to.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => ConfigsPage()),
        Router('/usuarios', module: UsuariosModule()),
        Router('/empresas', module: EmpresasModule()),
      ];

  static Inject get to => Inject<ConfigsModule>.of();
}
