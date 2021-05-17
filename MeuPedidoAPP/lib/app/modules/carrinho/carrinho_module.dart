import 'package:flutter_modular/flutter_modular.dart';

import 'carrinho_controller.dart';
import 'carrinho_page.dart';
import 'repository/carrinho_repository.dart';
import 'carrinho_lista.dart';

class CarrinhoModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoRepository()),
        Bind((i) => CarrinhoController(i.get<CarrinhoRepository>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => CarrinhoListaPage()),
        ModularRouter('/finaliza', child: (_, args) => CarrinhoPage()),
      ];

  static Inject get to => Inject<CarrinhoModule>.of();
}
