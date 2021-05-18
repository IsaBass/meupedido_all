import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'package:MeuPedido/app/app_controller.dart';

import 'pedido_controller.dart';
import 'pedido_page.dart';
import 'repository/pedido_repository.dart';

class PedidoModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => PedidoRepository(
            Modular.get<AppController>(), Modular.get<AuthController>())),
        Bind((i) => PedidoController(i.get<PedidoRepository>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:id',
        child: (_, args) => PedidoPage(
              idPedido: args.params['id'],
            )),
  ];

  // static Inject get to => Inject<PedidoModule>.of();
}
