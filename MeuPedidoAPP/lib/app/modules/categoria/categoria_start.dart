import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:MeuPedido/app/widgets/produtos/grid_product.dart';
import 'package:MeuPedido/app/widgets/produtos/slider_item.dart';

import 'categoria_controller.dart';
import 'categoria_module.dart';
import 'widget/home_seletorcategoria.dart';

class CategoriaStart extends StatefulWidget {
  @override
  CategoriaStartState createState() => CategoriaStartState();
}

class CategoriaStartState extends State<CategoriaStart> {
  ///
  final CategoriaController _controller = CategoriaModule.to.get();
  final AppController _appController = AppModule.to.get();

  List<T> map<T>(List list, Function handler) {
    var result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  //int _current = 0;

  @override
  Widget build(BuildContext context) {
    //super.build(context);
    print('desenhou build de CategoriaStart_tab.dart');
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          //backgroundColor: Theme.of(context).accentColor,
          //textTheme: Theme.of(context).accentTextTheme,
          title: Text('Logo da loja Start'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.textsms),
              onPressed: () async {
                var retorno = await Modular.to.pushNamed('agmercadopago');
                print(' retorno MP em CategoriaStart_page =  $retorno');
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: ListView(
            children: <Widget>[
              // Container(
              //   //height: 30,
              //   child: Text('Usuario logado = ${_authController.userAtual?.nome} '
              //       '\n na empresa ${_cnpjsController.cnpjAtivo?.descricao} ${_cnpjsController.cnpjAtivo?.docId} '),
              // ),

              //_tituloCategorias(),
              SeletorCategoriaHome(),
              SizedBox(height: 5.0),
              //_tituloDestaques(context),
              //SizedBox(height: 12.0),
              _caroulselDestaques(context),
              //SizedBox(height: 12.0),
              //SizedBox(height: 10.0),
              //_seletorCategoria(),
              SizedBox(height: 10.0),
              _tituloMaisPedidos(context),
              SizedBox(height: 10.0),
              // _gridProdutosMaisPedidos(context),
              Observer(builder: (_) {
                if (_controller.prodsTodosDestaque == null ||
                    _controller.prodsTodosDestaque?.length == 0) {
                  return Container();
                }
                return gridProdutos(context, _controller.prodsTodosDestaque);
              }),

              Observer(builder: (_) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text('Selecione o Tema'),
                        trailing: DropdownButton<String>(
                          value: _appController.codTemaAtual,
                          items: MeusTemas.listDDTemas,
                          onChanged: _appController.setCodTemaAtual,
                        ),
                      ),
                      SwitchListTile(
                        title: Text('Dark Mode'),
                        value: _appController.temaDark ?? false,
                        onChanged: _appController.setTemaDark,
                      ),
                    ],
                  ),
                );
              }),
              Text('v.P.5'),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // Text _tituloCategorias() {
  //   return Text(
  //     "Categorias",
  //     style: TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.w800,
  //     ),
  //   );
  // }

  Widget _caroulselDestaques(BuildContext context) {
    return Observer(builder: (_) {
      if (_controller.prodsDestaqueGeral == null) {
        return Container();
      }
      return CarouselSlider(
        options: CarouselOptions(
          // original era 0.416
          height: MediaQuery.of(context).size.height * 0.37,
          autoPlayCurve: Curves.easeInOut,
          autoPlayAnimationDuration: Duration(milliseconds: 1500),
          autoPlay: true,
          //enlargeCenterPage: true,
          viewportFraction: 1.0,
          // aspectRatio: 2.0,
        ),
        items: _controller.prodsDestaqueGeral
            .map((e) => SliderItem(prod: e))
            .toList(),
        // onPageChanged: (index) {
        //   setState(() {
        //     _current = index;
        //   });
        // },
      );
    });
  }

  // Row _tituloDestaques(BuildContext context) {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       Text(
  //         "Destaques",
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w800,
  //         ),
  //       ),
  //       // FlatButton(
  //       //   child: Text(
  //       //     "Ver mais...",
  //       //     style: TextStyle(
  //       //       color: Theme.of(context).primaryColor,
  //       //     ),
  //       //   ),
  //       //   onPressed: () {},
  //       // ),
  //     ],
  //   );
  // }

  Row _tituloMaisPedidos(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "nossos destaques",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        // FlatButton(
        //   child: Text(
        //     "Ver mais...",
        //     style: TextStyle(
        //       color: Theme.of(context).primaryColor,
        //     ),
        //   ),
        //   onPressed: () {},
        // ),
      ],
    );
  }
}
