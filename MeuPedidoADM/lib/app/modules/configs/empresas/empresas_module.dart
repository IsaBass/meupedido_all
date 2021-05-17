import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'edit.empresa_page.dart';
import 'empresas_controller.dart';
import 'empresas_page.dart';

class EmpresasModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EmpresasController(AppModule.to.get<CnpjRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => EmpresasPage()),
        Router('/edit', child: (_, args) => EditEmpresaPage(empresa: args.data['emp'], funcSalvar: args.data['func'],)),
        //Router('/filial', child: (_, args) => EditFilialPage(empresa: args.data['emp'],filial: args.data['filial'], funcSalvar: args.data['func'],)),
      ];

  static Inject get to => Inject<EmpresasModule>.of();
}
