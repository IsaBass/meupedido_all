import 'package:MeuPedido/app/widgets/produtos/favorito.botao.dart';
import 'package:MeuPedido/app/widgets/produtos/painel.adicionais.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'proddetails_controller.dart';
import 'proddetails_module.dart';
import 'widgets/barra_compra.dart';

class ProdDetailsPage extends StatefulWidget {
  final String codigoProd;

  const ProdDetailsPage({Key key, @required this.codigoProd}) : super(key: key);

  @override
  _ProdDetailsPageState createState() => _ProdDetailsPageState();
}

class _ProdDetailsPageState extends State<ProdDetailsPage> {
  ///
  final ProddetailsController _controller = ProddetailsModule.to.get();
  // final AppController _appController = AppModule.to.get();
  //final CartController _cartController = AppModule.to.get();
  // final AuthController _authController = AppModule.to.get();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool isFav = false;
  bool carregouInicial = false;
  ProdutoModel prod;
  final formatMoeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

  Future<void> getProduto() async {
    if (!carregouInicial) {
      _controller.prod = await _controller.getProduto(widget.codigoProd);
      prod = _controller.prod;
      carregouInicial = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild page details');

    return Scaffold(
      key: _scaffoldKey,
      body: FutureBuilder(
          future: getProduto(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return _scaffAguardando();
            }
            if (snapshot.hasError || prod == null) return _scaffNaoEncontrado();

            return SafeArea(
              child: Scaffold(
                body: _sliver(),
                //  _listViewConteudo(context),
                bottomNavigationBar: BarraCompraDet(
                  controller: _controller,
                  prod: prod,
                  scaffoldKey: _scaffoldKey,
                ),
                //_barraCompra(context),
              ),
            );
          }),
    );
  }

  Widget _sliver() {
    return Stack(
      children: <Widget>[
        //_buildBodyBack(),
        CustomScrollView(
          slivers: <Widget>[
            sliverAppBAr(),
            // Observer(builder: (_) {
            //   return SliverToBoxAdapter(
            //       child: exibeCarregandoLinha(isLoading: controller.isLoading));
            // }),
            makeSliverHeader(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(children: [
                      Text(
                        prod?.descricao ?? '',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      _apresentacaoPreco(prod, context)
                    ]),
                  ],
                ),
              ),
              maxHeight: 75,
              minHeight: 75,
              //backgroundColor: Colors.white,
            ),

            //SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(child: _descritivoProduto(prod)),
            //SliverToBoxAdapter(child: SizedBox(height: 15.0)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PainelAdicional(
                    grupoAdicionais: prod.grupoAdicionais,
                    atualizeAlgo: _controller.updFalso),
              ),
            ),
            //SliverFillRemaining(child: SizedBox(height: 15.0)),
          ],
        ),
      ],
    );
  }

  Widget _descritivoProduto(ProdutoModel prod) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Descritivo do Produto",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
            maxLines: 2,
          ),
          SizedBox(height: 10.0),
          Text(
            '${prod?.descritivo}',
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Padding _apresentacaoPreco(ProdutoModel prod, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
      child: Row(
        children: <Widget>[
          Text(
            // TODO: apresentação do produto
            "unid",
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(width: 10.0),
          Text(
            "${formatMoeda.format(prod?.precoAtual)}",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Stack _imgProduto(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3.2,
          width: MediaQuery.of(context).size.width,
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(8.0),
            child: agImageProvider(
                imgUrl: prod.img, imgTipo: prod.imgTipo, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          right: -10.0,
          bottom: 3.0,
          child: BtnFavorito(codigoProduto: prod.codigo),
        ),
      ],
    );
  }

  Widget sliverAppBAr() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leading: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)),
          boxShadow: [BoxShadow(blurRadius: 10)],
        ),
        height: 50,
        width: 50,
        alignment: Alignment.center,
        child: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      expandedHeight: MediaQuery.of(context).size.height / 3.2,
      // pinned: true, // mantmem fixo em cima, em modo menor
      floating: true, // << faz reaparecer quando rola pra baixo
      stretch: false,
      //snap: true, // volta totalmente quando rola para baixo
      backgroundColor: Colors.transparent, //Theme.of(context).accentColor,
      elevation: 20.0,
      //title: const Text("Pedidos", textAlign: TextAlign.center),
      flexibleSpace: FlexibleSpaceBar(
        background: CarouselSlider(
          items: [_imgProduto(context)],
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
          ),
        ),
        //title: Text('Pedidos'),
        centerTitle: false,
      ),
      // actions: <Widget>[Cestinha()],
    );
  }

  Scaffold _scaffNaoEncontrado() {
    return Scaffold(
        appBar: AppBar(
          title: Text("Não encontrado..."),
        ),
        body: Center(
            child: Text('Erro na requisição!\nProduto não encontrado.')));
  }

  Scaffold _scaffAguardando() {
    return Scaffold(
        appBar: AppBar(title: Text("aguardando...")),
        body: Center(child: exibeCarregandoCircular()));
  }

  //
  // IconButton _iconeNotificacoes() {
  //   return IconButton(
  //     icon: IconBadge(
  //       icon: Icons.notifications,
  //       size: 22.0,
  //       numero: 0,
  //     ),
  //     onPressed: () {
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (BuildContext context){
  //       //       return Notifications();
  //       //     },
  //       //   ),
  //       // );
  //     },
  //   );
  // }

  //  IconButton _iconeNovoTemporario() {
  //   return IconButton(
  //     icon: Icon(Icons.add_a_photo),
  //     onPressed: () {
  //       _controller.criarCopiaProduto(widget.prod);

  //     },
  //   );
  // }
}

// class _SliverAppbar extends StatelessWidget {
//   // final PedidosController controller;
//   // final AuthController authController;

//   const _SliverAppbar({Key key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {

//     return SliverAppBar(
//       expandedHeight: 300,
//       // pinned: true, // mantmem fixo em cima, em modo menor
//       floating: true, // << faz reaparecer quando rola pra baixo
//       stretch: false,
//       //snap: true, // volta totalmente quando rola para baixo
//       backgroundColor: Colors.transparent, //Theme.of(context).accentColor,
//       elevation: 20.0,
//       //title: const Text("Pedidos", textAlign: TextAlign.center),
//       flexibleSpace: FlexibleSpaceBar(
//         background:     imgProduto(context),
//         title: Text('Pedidos'),
//         centerTitle: false,
//       ),
//       // actions: <Widget>[Cestinha()],
//     );
//   }
// }
// Column _comentarios() {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Text(
//         "Reviews",
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.w800,
//         ),
//         maxLines: 2,
//       ),
//       SizedBox(height: 20.0),
//       ListView.builder(
//         shrinkWrap: true,
//         primary: false,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: comments == null ? 0 : comments.length,
//         itemBuilder: (BuildContext context, int index) {
//           Map comment = comments[index];
//           return ListTile(
//             leading: CircleAvatar(
//               radius: 25.0,
//               backgroundImage: AssetImage(
//                 "${comment['img']}",
//               ),
//             ),
//             title: Text("${comment['name']}"),
//             subtitle: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     SmoothStarRating(
//                       starCount: 5,
//                       color: Constants.ratingBG,
//                       allowHalfRating: true,
//                       rating: 5.0,
//                       size: 12.0,
//                     ),
//                     SizedBox(width: 6.0),
//                     Text(
//                       "February 14, 2020",
//                       style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 7.0),
//                 Text(
//                   "${comment["comment"]}",
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     ],
//   );
// }

// Padding _scoreRating() {
//   return Padding(
//     padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
//     child: Row(
//       children: <Widget>[
//         SmoothStarRating(
//           starCount: 5,
//           color: Constants.ratingBG,
//           allowHalfRating: true,
//           rating: 5.0,
//           size: 10.0,
//         ),
//         SizedBox(width: 10.0),
//         Text(
//           "5.0 (23 Reviews)",
//           style: TextStyle(
//             fontSize: 11.0,
//           ),
//         ),
//       ],
//     ),
//   );
// }
