import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';

import '../carrinho_controller.dart';

class PainelPagamMercadoPago extends StatefulWidget {
  @override
  _PainelPagamMercadoPagoState createState() => _PainelPagamMercadoPagoState();
}

class _PainelPagamMercadoPagoState extends State<PainelPagamMercadoPago> {
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  bool _tentativaFalhou = false;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return !(_carrinhoController.formaPagamento == 'ONLINE')
          ? Container()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
              child: Card(
                elevation: 4,
                child: _botaoPagar(context),
              ),
            );
    });
  }

  Container _botaoPagar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Column(
        children: [
          !_tentativaFalhou
              ? Container()
              : Column(
                  children: [
                    Icon(FontAwesomeIcons.frownOpen,
                        size: 60, color: Theme.of(context).accentColor),
                    SizedBox(height: 10),
                    Text(
                      'Parece que você desistiu do Cartão\n'
                      'Tente novamente ou escolha outra forma',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            icon: Icon(
              FontAwesomeIcons.creditCard,
              color: Theme.of(context).primaryTextTheme.bodyText1.color,
            ),
            label: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Pagar pelo Mercado Pago\ne finalizar Pedido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.bodyText1.color,
                ),
              ),
            ),
            onPressed: () async {
              var idPedido = await _carrinhoController.gravarPedidoTemporario();
              var pedido = _carrinhoController.criarPedido(
                  pedido: Pedido(docId: idPedido));

              var retorno = await Modular.to.pushNamed('/agmercadopago')
                  as Map<dynamic, dynamic>;
              print(' retorno em painel pagam =  $retorno');

              if (retorno["tipoResposta"] != "PagamentoOK") {
                setState(() => _tentativaFalhou = true);
                _carrinhoController.excluirPedidoTemporario(idPedido);
                return;
              }

              // aqui manda informacoes do cartao, uncluindo o idPedido
              pedido.pagamentos[0].codPag = 'MercadoPago';
              pedido.pagamentos[0].mecanismoCartao = 'MercadoPago';
              //
              pedido.pagamentos[0].codAutorizacao = retorno["idPagamento"];
              // pedido.pagamentos[0].numNSU = ;
              pedido.pagamentos[0].parcelas = 0;
              pedido.pagamentos[0].idVendaCartao = retorno["idPreference"];

              pedido.pagamentos[0].bandeira =
                  retorno["bandeira"].toString().toUpperCase();
              pedido.pagamentos[0].descricao =
                  retorno["creditoDebito"] == 'credit_card'
                      ? 'Cartão Crédito'
                      : 'Cartão Débito';
              pedido.pagamentos[0].tipo =
                  retorno["creditoDebito"] == 'credit_card'
                      ? 'CTCRED'
                      : 'CTDEB';

              await _carrinhoController.gravarPedido(pedido);

              // DONE: CHAMAR TELA DE FINALIZAÇÃO DA VENDA / CONFIRMADO
              await showPergunta(
                title: 'Pedido Confirmado',
                desc:
                    'Seu Pedido ${pedido.codpedido} foi confirmado com Sucesso.' +
                        '\nAcompanhe-o pelo menu de pedidos',
                botaoNao: 'OK',
                botaoSim: '',
                context: context,
              );

              Modular.to.popUntil(ModalRoute.withName('/home'));
            },
          ),
        ],
      ),
    );
  }
}
