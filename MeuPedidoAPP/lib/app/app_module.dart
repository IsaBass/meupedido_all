import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedido_core/core/cart/cart_repository.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'app_controller.dart';
import 'app_repository.dart';
import 'app_widget.dart';
import 'categs/categs_controller.dart';
import 'categs/categs_repository.dart';

import 'modules/carrinho/carrinho_module.dart';
import 'modules/categoria/categoria_module.dart';
import 'modules/categoria/categoria_page.dart';
import 'modules/endereco/endereco_module.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/pedido/pedido_module.dart';
import 'modules/proddetails/proddetails_module.dart';
import 'modules/splash/splash_module.dart';

import 'utils/card_type/cardtype_repository.dart';
import 'utils/mercado_pago/ag.mercado_pago.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => CnpjRepository()),
        Bind((i) => CNPJSController(i.get())),
        Bind((i) => AuthRepository(i.get())),
        Bind((i) => AuthController(i.get(), i.get())),
        Bind((i) => AppRepository(i.get<CNPJSController>())),
        Bind((i) => AppController(i.get(), i.get(), i.get<AppRepository>())),
        Bind((i) => CartRepository()),
        Bind((i) => CartController(i.get(), i.get(), i.get())),
        Bind((i) => CardTypeRepository()),
        Bind((i) => CategsRepository()),
        Bind((i) => CategsController(i.get<CategsRepository>())),
        Bind((i) => FCMFirebase(), isLazy: false),
      ];

  @override
  List<ModularRoute> get routers => [
        ModuleRoute('/', module: SplashModule()),
        ModuleRoute('/login', module: LoginModule()),
        ModuleRoute('/home', module: HomeModule()),
        ModuleRoute('/proddetail', module: ProddetailsModule()),
        ModuleRoute('/cart', module: CarrinhoModule()),
        ModuleRoute('/endereco', module: EnderecoModule()),
        ModuleRoute('/pedido', module: PedidoModule()),
        ModuleRoute('/categoria', module: CategoriaModule()),
        ModuleRoute('/agmercadopago', child: (_, args) => AGMercadoPago()),
        ModuleRoute(
          'categoria/categ/:codcateg',
          child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
        ),
      ];

  // @override
  // Widget get bootstrap => AppWidget();

  // static Inject get to => Inject<AppModule>.of();
}
