import 'package:MeuPedido/app/modules/carrinho/widget/btns_carrinho.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toast/toast.dart';

import '../carrinho_controller.dart';
import '../widget/painel_formapagam.dart';
// import '../widget/pnl_cartao_cielo.dart';
import '../widget/painel_tippag_entrega.dart';

class CarrinhoPagamentoTab extends StatefulWidget {
  @override
  _CarrinhoPagamentoTabState createState() => _CarrinhoPagamentoTabState();
}

class _CarrinhoPagamentoTabState extends State<CarrinhoPagamentoTab> {
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      //mainAxisSize: MainAxisSize.max,
      children: [
        PainelFormaPagamento(),
        PainelTipPagEntrega(),
        //PainelPagamMercadoPago(),
        //  PainelTipPagOnline(),
        //PainelCartaoCielo(),
        _botaoSalvar(context),
      ],
    );
  }

  Widget _botaoSalvar(BuildContext context) {
    return Observer(builder: (_) {
      if (_carrinhoController.formaPagamento == 'ONLINE') return Container();

      return BtnsCarrinho(
        buttomLabel: 'Confirmar Pedido',
        icone: FontAwesomeIcons.save,
        onPressed: () async {
          var idPedido = await _carrinhoController
              .gravarPedido(_carrinhoController.criarPedido());

          Toast.show('Pedido: $idPedido', context);
          Modular.to.popUntil(ModalRoute.withName('/home'));
          //  Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home')    ) ;
        },
      );

      //     return Container(
      //       width: MediaQuery.of(context).size.width,
      //       padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
      //       child: RaisedButton.icon(
      //         color: Theme.of(context).primaryColor,
      //         icon: Icon(
      //           FontAwesomeIcons.save,
      //           color: Theme.of(context).primaryTextTheme.bodyText1.color,
      //         ),
      //         label: Text(
      //           'Confirmar Pedido',
      //           style: TextStyle(
      //             color: Theme.of(context).primaryTextTheme.bodyText1.color,
      //           ),
      //         ),
      //         //_authController.isLoading == true
      //         //     ? Center(
      //         //         child: CircularProgressIndicator(),
      //         //       )
      //         //     : Text(
      //         //         modoEdicao ? " Salvar" : ' Cadastrar',
      //         //         style: TextStyle(fontSize: 18,
      //         //             color: Theme.of(context).primaryTextTheme.bodyText1.color),
      //         //       ),
      //         onPressed: () async {
      //           var idPedido = await _carrinhoController
      //               .gravarPedido(_carrinhoController.criarPedido());

      //           Toast.show('Pedido: $idPedido', context);
      //           Modular.to.popUntil(ModalRoute.withName('/home'));
      //           //  Navigator.pushNamedAndRemoveUntil(context, '/home', ModalRoute.withName('/home')    ) ;
      //         },
      //       ),
      //     );
    });
  }
}
