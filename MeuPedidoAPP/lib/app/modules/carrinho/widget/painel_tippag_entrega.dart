import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../carrinho_controller.dart';

class PainelTipPagEntrega extends StatelessWidget {
 final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return !(_carrinhoController.formaPagamento == 'INLOCO')
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Text('Escolha o pagamento na Entrega:'),
                    ),
                    Container(
                      height: 40,
                      child: RadioListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text('Em dinheiro'),
                        groupValue: _carrinhoController.tipoPagamento,
                        value: 'DIN',
                        onChanged: _carrinhoController.setTipoPagamento,
                      ),
                    ),
                    Container(
                      height: 40,
                      child: RadioListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text('Cartão de Crédito'),
                        groupValue: _carrinhoController.tipoPagamento,
                        value: 'CTCRED',
                        onChanged: _carrinhoController.setTipoPagamento,
                      ),
                    ),
                    Container(
                      height: 60,
                      //padding: EdgeInsets.only(bottom: 5),
                      child: RadioListTile(
                        activeColor: Theme.of(context).accentColor,
                        title: Text('Cartão de Débito'),
                        groupValue: _carrinhoController.tipoPagamento,
                        value: 'CTDEB',
                        onChanged: _carrinhoController.setTipoPagamento,
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}