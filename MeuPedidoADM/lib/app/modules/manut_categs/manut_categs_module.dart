import 'package:meupedidoADM/app/app_controller.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'manut_categs_controller.dart';
import 'manut_categs_page.dart';
import 'repository/manut_categs_repository.dart';
import 'widgets/formcad.categ.dart';

class ManutCategsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ManutCategsRepository(AppModule.to.get<AppController>())),
        Bind((i) => ManutCategsController(i.get())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => ManutCategsPage()),
        Router('/edit',
            child: (_, args) => CadCategForm(
                  categ: args.data['categ'],
                )),
      ];

  static Inject get to => Inject<ManutCategsModule>.of();
}
