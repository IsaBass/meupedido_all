import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'usuarios_controller.dart';
import 'usuarios_page.dart';
import 'repository/usuarios_repository.dart';

class UsuariosModule extends ChildModule {
  final String cnpj;

  UsuariosModule({this.cnpj});

  @override
  List<Bind> get binds => [
        Bind((i) =>
            UsuariosController(i.get(), AppModule.to.get<CNPJSController>())),
        Bind((i) => UsuariosRepository()),
      ];

  @override
  List<Router> get routers => [
        Router('/:cnpj',
            child: (_, args) => UsuariosPage(cnpj: args.params['cnpj'])),
      ];

  static Inject get to => Inject<UsuariosModule>.of();
}
