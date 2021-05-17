import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../carrinho_controller.dart';

class PainelFormaPagamento extends StatelessWidget {
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();
  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        child: Card(
          elevation: 4,
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 10, left: 15),
                child: Text('Forma de Pagamento:'),
              ),
              Container(
                height: 40,
                child: RadioListTile(
                  activeColor: Theme.of(context).accentColor,
                  title: Text('Pagamento na Entrega'),
                  groupValue: _carrinhoController.formaPagamento,
                  value: 'INLOCO',
                  onChanged: _carrinhoController.setformaPagamento,
                ),
              ),
              RadioListTile(
                title: Text('Cartão On-line'),
                activeColor: Theme.of(context).accentColor,
                groupValue: _carrinhoController.formaPagamento,
                value: 'ONLINE',
                onChanged: _carrinhoController.setformaPagamento,
              ),
            ],
          ),
        ),
      );
    });
  }
}