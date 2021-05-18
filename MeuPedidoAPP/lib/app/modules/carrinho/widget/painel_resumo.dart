import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/core/cart/cart_controller.dart';

class CartPainelResumo extends StatelessWidget {
  final CartController _cartController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _cartController.cartAtual.itens?.length == 0
          ? Container(height: 0)
          : _pnlVlrFinal(context);
    });
  }

  Widget _pnlVlrFinal(BuildContext context) {
    final formata = NumberFormat.simpleCurrency(locale: 'pt_BR');

    Widget _valorTotal() => Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          height: 18,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${_cartController.cartAtual.qtdItens} itens'),
              Text(
                'Total: ${formata.format(_cartController.cartAtual.valorTotal)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ],
          ),
        );

    Widget _valorDesconto() => Observer(
          builder: (_) =>
              (_cartController.cartAtual.descontoValor ?? 0.0) != 0.0
                  ? Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      height: 18,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'Cupom: ${_cartController.cartAtual.cupomAplicado?.tagCupom ?? ''}'),
                          Text(
                            'Desconto: - ${formata.format(_cartController.cartAtual.descontoValor)}',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    )
                  : Container(),
        );
    Widget _valorFrete() => Observer(
          builder: (_) => (_cartController.cartAtual.vlrFrete ?? 0.0) != 0.0
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 18,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Frete: ${formata.format(_cartController.cartAtual.vlrFrete)}',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                )
              : Container(),
        );

    return Container(
      //height: 80.0,
      color: Theme.of(context).backgroundColor.withAlpha(100),
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 0),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          _valorFrete(),
          _valorDesconto(),
          _valorTotal(),
        ],
      ),
    );
  }
}
