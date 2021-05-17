import 'package:meupedidoADM/app/app_controller.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedidoADM/app/modules/manut_prods/manut_prods_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/modules/manut_prods/manut_prods_page.dart';
import 'package:meupedidoADM/app/modules/manut_prods/repository/manut_prods_repository.dart';

class ManutProdsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ManutProdsController(i.get())),
        Bind((i) => ManutProdsRepository(AppModule.to.get<AppController>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => ManutProdsPage()),
      ];

  static Inject get to => Inject<ManutProdsModule>.of();
}
