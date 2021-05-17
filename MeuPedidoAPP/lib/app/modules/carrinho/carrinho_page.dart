import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'carrinho_controller.dart';
import 'carrinho_module.dart';
import 'tabs/carr_endereco_tab.dart';
import 'tabs/carr_pagams_tab.dart';
import 'widget/painel_resumo.dart';

class CarrinhoPage extends StatefulWidget {
  final String title;
  const CarrinhoPage({Key key, this.title = "Sua seleção"}) : super(key: key);

  @override
  _CarrinhoPageState createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  final CarrinhoController _carrinhoController =
      CarrinhoModule.to.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Finalizando Compra...'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: () {
            if (_carrinhoController.pageController.page.truncate() > 0) {
              _carrinhoController.pageController.previousPage(
                duration: Duration(milliseconds: 800),
                curve: Curves.easeIn,
              );
            } else {
              Modular.to.pop();
            }
          },
        ),
      ),
      bottomNavigationBar: CartPainelResumo(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _carrinhoController.pageController,
        scrollDirection: Axis.horizontal,
        children: [
          //CarrinhoTabLista(),
          CarrinhoEnderecoTab(),
          CarrinhoPagamentoTab(),
        ],
      ),
    );
  }
}
