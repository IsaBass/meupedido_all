import 'package:MeuPedido/app/app_module.dart';
import 'package:MeuPedido/app/categs/categs_controller.dart';
import 'package:MeuPedido/app/modules/carrinho/carrinho_module.dart';
import 'package:MeuPedido/app/modules/categoria/categoria_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'home_controller.dart';
import 'home_module.dart';
import 'tabs/favoritos/favoritos_tab.dart';
import 'tabs/meuspedidos/meuspedidos_tab.dart';
import 'tabs/perfil/perfil_tab.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeController _controller = HomeModule.to.get<HomeController>();

  final CategsController _categsController =
      AppModule.to.get<CategsController>();
  final AuthController _authController = AppModule.to.get();
  final CartController _cartController = AppModule.to.get();
  final CNPJSController _cnpjsController = AppModule.to.get<CNPJSController>();

  //int _page = 1;

  @override
  void initState() {
    print('inistate do home_page');
    super.initState();
    // _controller.fetchProdsDestaqueGeral();
    _categsController.recarregaAllCategs();

    //_cartController.carregaCarrinhoUser();
    if (_cnpjsController.cnpjAtivo == null) {
      print('homepage::: nao tenho cnpj ativo');
      Modular.to.popAndPushNamed('/');
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('entrou do init');
      carregaUsuario();
    });
  }

  void carregaUsuario() {
    _authController.setLoading();

    _authController.loadCurrentUser().then((_) {
      if (_authController.estaLogado) {
        print('na tela home_page:: estaLogado com sucesso');
        AppModule.to.get<CartController>().carregaCarrinhoUser();
      }
      _authController.setNoLoading();
    }).catchError((e) {
      print('erro ao logar na tela splach');
      _authController.setNoLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build de home_page');

    ///
    AppModule.to.get<FCMFirebase>().inicializeFCM(context);

    ///
    return
        // WillPopScope(
        //   onWillPop: () => Future.value(false),
        //   child:
        Scaffold(
      // appBar: AppBar(
      //   title: Observer(builder: (_) => Text(_controller.tituloTab)),
      //   centerTitle: true,
      // ),

      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller.pageController,
        onPageChanged: _controller.setTabActive, //onPageChanged,
        children: <Widget>[
          RouterOutlet(module: CategoriaModule()),
          FavoritosTab(),
          RouterOutlet(module: CarrinhoModule()),
          MeusPedidosTab(),
          PerfilTab(),
        ],
      ),
      bottomNavigationBar: bottomAppBar(),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        //  backgroundColor: Theme.of(context).primaryColor,
        elevation: 4.0,
        //label: Text('6 itens'),
        child: Observer(builder: (_) {
          return IconBadge(
            icon: FontAwesomeIcons.shoppingBasket,
            size: 24.0,
            numero: _cartController.cartAtual?.qtdItens ?? 0,
          );
        }),
        onPressed: () => _controller.pageController.jumpToPage(2),
        //Modular.to.pushNamed('/cart'),
      ),
      // ),
    );
  }

  Widget bottomAppBar() {
    ///
    // Color corIcone(int idx) {
    //   return _controller.tabActive == idx
    //       ? Theme.of(context).primaryColor
    //       : Theme.of(context).textTheme.caption.color;
    // }

    return AnimatedBuilder(
        animation: _controller.pageController,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).textTheme.caption.color,
            currentIndex: _controller.tabActive,
            onTap: (index) {
              _controller.pageController.jumpToPage(index);
              // _controller.pageController.animateToPage(
              //   index,
              //   duration: Duration(milliseconds: 200),
              //   curve: Curves.easeOut,
              // );
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home, size: 24.0),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite, size: 24.0),
                title: Text('Favoritos'),
              ),
              BottomNavigationBarItem(
                title: Text('Carrinho'),
                icon: Icon(
                  Icons.shopping_cart,
                  size: 24.0,
                  color: Theme.of(context).bottomAppBarColor,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.listUl, size: 24.0),
                title: Text('Compras'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person, size: 24.0),
                title: Text('Perfil'),
              ),
            ],
          );
        });

    // ///
    // return BottomAppBar(
    //   //clipBehavior: Clip.hardEdge,
    //   elevation: 10,
    //   // color: Theme.of(context).accentColor,
    //   shape: CircularNotchedRectangle(),
    //   child: Observer(builder: (_) {
    //     return Row(
    //       mainAxisSize: MainAxisSize.max,
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: <Widget>[
    //         SizedBox(width: 7),
    //         IconButton(
    //           icon: Icon(Icons.home, size: 24.0),
    //           color: corIcone(0),
    //           onPressed: () => _controller.pageController.jumpToPage(0),
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.favorite, size: 24),
    //           color: corIcone(1),
    //           onPressed: () => _controller.pageController.jumpToPage(1),
    //         ),
    //         IconButton(
    //           icon: Icon(
    //             Icons.shopping_cart,
    //             size: 24,
    //             color: Theme.of(context).bottomAppBarColor,
    //           ),
    //           color: Theme.of(context).accentColor,
    //           onPressed: () => _controller.pageController.jumpToPage(2),
    //         ),
    //         IconButton(
    //           icon: Icon(FontAwesomeIcons.listUl, size: 22),
    //           color: corIcone(3),
    //           onPressed: () => _controller.pageController.jumpToPage(3),
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.person, size: 24),
    //           color: corIcone(4),
    //           onPressed: () => _controller.pageController.jumpToPage(4),
    //         ),
    //         SizedBox(width: 7),
    //       ],
    //     );
    //   }),
    // );
  }

  // void onPageChanged(int page) {
  //  // _controller.setTabActive(page)

  // }
}

// SingleChildScrollView(
//   child: Column(
//     children: [
//       seletorCategorias(),
//       Observer(builder: (_) {
//         return Center(
//           child: Text('Categ selected: \n' + _controller.categAtiva,
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 30)),
//         );
//       }),

//     ],
//   ),
// ),
