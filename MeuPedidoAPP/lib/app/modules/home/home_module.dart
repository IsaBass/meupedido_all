import 'package:MeuPedido/app/app_controller.dart';

import 'package:MeuPedido/app/modules/categoria/categoria_page.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';
import 'home_page.dart';

import 'tabs/favoritos/favoritos_controller.dart';
import 'tabs/favoritos/favoritos_repository.dart';
import 'tabs/meuspedidos/meuspedidos_controller.dart';
import 'tabs/meuspedidos/meuspedidos_repository.dart';
import 'tabs/perfil/edit_usuario.dart';
import 'tabs/perfil/enderecos/list_enderecos.dart';
import 'tabs/perfil/enderecos/list_enderecos_controller.dart';
import 'tabs/perfil/enderecos/list_enderecos_repository.dart';
import 'tabs/search/search_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        // Bind((i) => HomeRepository()),
        Bind.singleton((i) => HomeController()),
        Bind.singleton(
            (i) => FavoritosRepository(Modular.get<AppController>())),
        Bind.singleton((i) => FavoritosController(i(), Modular.get())),
        Bind.singleton((i) => SearchController(Modular.get())),
        Bind.singleton(
          (i) => ListEnderecosController(
            ListEnderecosRepository(Modular.get<AppController>()),
          ),
        ),
        Bind.singleton(
            (i) => MeusPedidosRepository(Modular.get<AppController>())),
        Bind.singleton((i) => MeusPedidosController(i())),
        //
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => HomePage()),
    ChildRoute('/editusuario', child: (_, args) => PerfilEditUsuario()),
    ChildRoute('/listenderecos', child: (_, args) => PerfilListaEnderecos()),
    ChildRoute(
      'categ/:codcateg',
      child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
    ),
  ];

  // @override
  // Widget get view {
  //   Modular.init(this);
  //   return HomePage();
  // }

  static Inject get to => Inject<HomeModule>();
}
