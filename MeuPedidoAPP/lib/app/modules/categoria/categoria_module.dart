import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_controller.dart';

import 'categoria_start.dart';
import 'repository/categoria_repository.dart';

class CategoriaModule extends WidgetModule {
  // extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind.singleton((i) => CategoriaRepository()),
        Bind.singleton(
            (i) => CategoriaController(i.get<CategoriaRepository>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CategoriaStart()),
    // ChildRoute(
    //   'categ/:codcateg',
    //   child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
    // ),
  ];

  @override
  Widget get view {
    // Modular.init(this);
    Modular.bindModule(this);

    return CategoriaStart();
  }

  static Inject get to => Inject<CategoriaModule>();
}
