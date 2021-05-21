import 'package:flutter_modular/flutter_modular.dart';

import 'package:MeuPedido/app/app_controller.dart';

import 'proddetails_controller.dart';
import 'proddetails_page.dart';
import 'repository/proddetails_repository.dart';

class ProddetailsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => ProddetailsRepository(Modular.get<AppController>())),
        Bind((i) => ProddetailsController(i.get<ProddetailsRepository>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/:cod',
        child: (_, args) => ProdDetailsPage(codigoProd: args.params['cod'])),
  ];

  static Inject get to => Inject<ProddetailsModule>();
}
