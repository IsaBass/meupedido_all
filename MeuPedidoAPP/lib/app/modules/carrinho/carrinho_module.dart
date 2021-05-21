import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'carrinho_controller.dart';
import 'carrinho_page.dart';
import 'repository/carrinho_repository.dart';
import 'carrinho_lista.dart';

class CarrinhoModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CarrinhoRepository(Modular.get<AppController>())),
        Bind(
          (i) => CarrinhoController(
            i(),
            Modular.get<CartController>(),
            Modular.get<AppController>(),
            Modular.get<FCMFirebase>(),
          ),
        ),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CarrinhoListaPage()),
    ChildRoute('/finaliza', child: (_, args) => CarrinhoPage()),
  ];

  static Inject get to => Inject<CarrinhoModule>();

  @override
  Widget get view {
    // Modular.init(this);
    Modular.bindModule(this);

    return CarrinhoListaPage();
  }
}
