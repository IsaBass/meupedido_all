import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_controller.dart';
import 'categoria_page.dart';
import 'categoria_start.dart';
import 'repository/categoria_repository.dart';

class CategoriaModule extends Module {
//extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CategoriaRepository()),
        Bind((i) => CategoriaController(i.get<CategoriaRepository>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => CategoriaStart()),
    ChildRoute(
      'categ/:codcateg',
      child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
    ),
  ];

  // @override
  // Widget get view {
  //   Modular.init(this);
  //   return CategoriaStart();
  // }

  static Inject get to => Inject<CategoriaModule>();
}
