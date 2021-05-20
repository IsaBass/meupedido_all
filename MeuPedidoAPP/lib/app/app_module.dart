import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/core/auth/services/auth_firebase_service.dart';

import 'package:meupedido_core/core/cart/cart_repository.dart';
import 'package:meupedido_core/core/meus_temas/theme_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'app_controller.dart';
import 'app_repository.dart';

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
        Bind.singleton((i) => ThemeController()),
        Bind.singleton((i) => CNPJSController(CnpjRepository())),
        Bind.singleton((i) => AuthFirebaseService()),
        Bind.singleton(
          (i) => AuthController(
            AuthRepository(),
            i.get<AuthFirebaseService>(),
            i<FCMFirebase>(),
          ),
        ),
        Bind.singleton(
          (i) => AppController(
            i.get<AuthController>(),
            i.get<CNPJSController>(),
            AppRepository(),
            i<CartController>(),
          ),
        ),
        Bind.singleton((i) => CartController(CartRepository())),
        Bind.singleton((i) => CardTypeRepository()),
        Bind.singleton((i) => CategsRepository()),
        Bind.singleton((i) => CategsController(
              i.get<CategsRepository>(),
              i(),
            )),
        Bind.singleton((i) => FCMFirebase()),
      ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/login', module: LoginModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/proddetail', module: ProddetailsModule()),
    ModuleRoute('/cart', module: CarrinhoModule()),
    ModuleRoute('/endereco', module: EnderecoModule()),
    ModuleRoute('/pedido', module: PedidoModule()),
    ModuleRoute('/categoria', module: CategoriaModule()),
    ChildRoute('/agmercadopago', child: (_, args) => AGMercadoPago()),
    ChildRoute(
      'categoria/categ/:codcateg',
      child: (_, args) => CategoriaPage(codCateg: args.params['codcateg']),
    ),
  ];

  // @override
  // Widget get bootstrap => AppWidget();

  // static Inject get to => Inject<AppModule>.of();
}
