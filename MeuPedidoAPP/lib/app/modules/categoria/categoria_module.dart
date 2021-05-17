import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_controller.dart';
import 'categoria_page.dart';
import 'categoria_start.dart';
import 'repository/categoria_repository.dart';

class CategoriaModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CategoriaRepository()),
        Bind((i) => CategoriaController(i.get<CategoriaRepository>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => CategoriaStart()),
        ModularRouter(
          '/categ/:codcateg',
          child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
        ),
      ];

  static Inject get to => Inject<CategoriaModule>.of();
}
