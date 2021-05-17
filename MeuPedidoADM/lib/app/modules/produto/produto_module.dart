import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_controller.dart';

import 'package:meupedidoADM/app/app_module.dart';

import 'produto_controller.dart';
import 'produto_page.dart';
import 'repository/produto_repository.dart';

class ProdutoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ProdutoRepository(AppModule.to.get<AppController>())),
        Bind((i) => ProdutoController(i.get<ProdutoRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/',
            child: (_, args) => ProdutoPage(
                prod: args.data['prod'], idCateg: args.data['idCateg'])),
      ];

  static Inject get to => Inject<ProdutoModule>.of();
}
