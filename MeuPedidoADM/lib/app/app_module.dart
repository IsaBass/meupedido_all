import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:meupedidoADM/app/modules/altera_adicional/altera_adic_controller.dart';
import 'package:meupedidoADM/app/modules/manut_categs/manut_categs_module.dart';
import 'package:meupedidoADM/app/modules/manut_prods/manut_prods_module.dart';
//
import 'package:meupedido_core/meupedido_core.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/altera_adicional/altera_adicional.dart';
import 'modules/configs/configs_module.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/produto/produto_module.dart';
import 'modules/splash/splash_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // Bind((i) => AppRepository()),
        Bind((i) => AppController(i.get(), i.get())),
        Bind((i) => CnpjRepository()),
        Bind((i) => CNPJSController(i.get())),
        Bind((i) => AuthRepository(i.get())),
        Bind((i) => AuthController(i.get(), i.get())),
        Bind((i) => AlteraAdicController()),
        // Bind((i) => CategsRepository()),
        // Bind((i) => CategsController(i.get())),
        Bind((i) => FCMFirebase(), lazy: false),
      ];

  @override
  List<Router> get routers => [
        Router('/', module: SplashModule()),
        Router('/login', module: LoginModule()),
        Router('/home', module: HomeModule()),
        Router('/configs', module: ConfigsModule()),
        Router('/categs', module: ManutCategsModule()),
        Router('/prods', module: ManutProdsModule()),
        Router('/prod', module: ProdutoModule()),
        Router('/altAdicionais',
            child: (_, args) => FormAlteraAdicional(grupo: args.data['grupo'])),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
