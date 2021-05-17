import 'package:flutter_modular/flutter_modular.dart';

import 'package:MeuPedido/app/app_module.dart';

import 'home_controller.dart';
import 'home_page.dart';
import 'repository/home_repository.dart';
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
        Bind((i) => HomeRepository()),
        Bind((i) => HomeController()),
        Bind((i) => FavoritosController(i.get<FavoritosRepository>())),
        Bind((i) => FavoritosRepository(Modular.get())),
        Bind((i) => SearchController()),
        Bind((i) => ListEnderecosRepository()),
        Bind((i) => ListEnderecosController(i.get<ListEnderecosRepository>())),
        Bind((i) => MeusPedidosController(i.get())),
        Bind((i) => MeusPedidosRepository()),
      ];

  @override
  List<ModularRoute> get routers => [
        ChildRoute('/', child: (_, args) => HomePage()),
        ChildRoute('/editusuario', child: (_, args) => PerfilEditUsuario()),
        ChildRoute('/listenderecos',
            child: (_, args) => PerfilListaEnderecos()),
      ];

  // static Inject get to => Inject<HomeModule>.of();
}
