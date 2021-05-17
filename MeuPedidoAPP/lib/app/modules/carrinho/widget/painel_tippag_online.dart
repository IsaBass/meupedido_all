import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../carrinho_controller.dart';

class PainelTipPagOnline extends StatelessWidget {
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return !(_carrinhoController.formaPagamento == 'ONLINE')
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Card(
                elevation: 4,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 10, left: 15),
                      child: Text('Escolha o Cartão On-line:'),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: RadioListTile(
                            activeColor: Theme.of(context).accentColor,
                            title: Text('Crédito'),
                            groupValue: _carrinhoController.tipoPagamento,
                            value: 'CTCRED',
                            onChanged: _carrinhoController.setTipoPagamento,
                          ),
                        ),
                        Expanded(
                          child: RadioListTile(
                            activeColor: Theme.of(context).accentColor,
                            title: Text('Débito'),
                            groupValue: _carrinhoController.tipoPagamento,
                            value: 'CTDEB',
                            onChanged: _carrinhoController.setTipoPagamento,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
