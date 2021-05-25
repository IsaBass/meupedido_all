import 'package:MeuPedido/app/modules/carrinho/widget/btns_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../carrinho_controller.dart';
import '../widget/painel_enderecos.dart';

class CarrinhoEnderecoTab extends StatefulWidget {
  @override
  _CarrinhoEnderecoTabState createState() => _CarrinhoEnderecoTabState();
}

class _CarrinhoEnderecoTabState extends State<CarrinhoEnderecoTab> {
  //
  final _carrinhoController = Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            _escolhaEntrega(),
            //_listaEnderecos(),
            PainelEnderecos(),
            _botaoFecharComprar(context),
          ],
        ),
      ),
    );
  }

  Widget _escolhaEntrega() {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 10, left: 15),
                child: Text('Selecione como deseja receber:'),
              ),
              RadioListTile(
                activeColor: Theme.of(context).accentColor,
                title: Text('Retirar no Local'),
                groupValue: _carrinhoController.tipoEntrega,
                value: 'RET',
                onChanged: _carrinhoController.setTipoEntrega,
              ),
              RadioListTile(
                title: Text('Receber em meu Endereço:'),
                activeColor: Theme.of(context).accentColor,
                groupValue: _carrinhoController.tipoEntrega,
                value: 'FRETE',
                onChanged: _carrinhoController.setTipoEntrega,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _botaoFecharComprar(BuildContext context) {
    return BtnsCarrinho(
      buttomLabel: "Prosseguir Pagamento",
      icone: Icons.monetization_on,
      onPressed: () => _carrinhoController.pageController.nextPage(
        duration: Duration(milliseconds: 800),
        curve: Curves.easeIn,
      ),
    );

    // return Container(
    //   padding: EdgeInsets.all(8),
    //   width: MediaQuery.of(context).size.width,
    //   child: RaisedButton.icon(
    //     icon: Icon(Icons.monetization_on,
    //         color: Theme.of(context).primaryTextTheme.bodyText1.color),
    //     label: Text(
    //       "Prosseguir Pagamento",
    //       style: TextStyle(
    //         color: Theme.of(context).primaryTextTheme.bodyText1.color,
    //       ),
    //     ),
    //     color: Theme.of(context).primaryColor,
    //     onPressed: () {
    //       // var numPedido = await _carrinhoController
    //       //     .gravarPedido(_carrinhoController.criarPedido());

    //       // Toast.show('Pedido: $numPedido', context);
    //       _carrinhoController.pageController.nextPage(
    //         duration: Duration(milliseconds: 800),
    //         curve: Curves.easeIn,
    //       );
    //     },
    //   ),
    // );
  }
}
