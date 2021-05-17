import 'package:MeuPedido/app/app_module.dart';

import 'package:MeuPedido/app/widgets/nao_logado.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'meupedido_model.dart';
import 'meuspedidos_controller.dart';

class MeusPedidosTab extends StatefulWidget {
  @override
  _MeusPedidosTabState createState() => _MeusPedidosTabState();
}

class _MeusPedidosTabState
    extends ModularState<MeusPedidosTab, MeusPedidosController> {
  final AuthController _authController = AppModule.to.get<AuthController>();
  // String userId;
  // String cnpj;

  @override
  void initState() {
    super.initState();
    //
    //  controller.streamMeusPedidos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meus Pedidos'), centerTitle: true),
      body: Observer(builder: (_) {
        return Padding(
          padding: EdgeInsets.all(5),
          child: _authController.estaLogado ? stramBuilder() : NaoLogado(),
        );
      }),
    );
  }

  Widget stramBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.streamMeusPedidos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: exibeCarregandoCircular());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Erro Sem pedidos'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('Sem pedidos'));
        }

        return ListView.builder(
          //primary: false,
          shrinkWrap: true,
          itemCount: snapshot.data.documents.length,
          itemBuilder: (ctx, idx) {
            //List aux = snapshot.data.documents.toList();
            var p = MeuPedido.fromJson(snapshot.data.documents[idx].data);
            return _cardPedido(p);
          },
        );
      },
    );
  }

  Card _cardPedido(MeuPedido e) {
    ////////
    var dataFormatada = formatDate(
        DateTime.fromMillisecondsSinceEpoch(e.dataHora),
        [dd, '/', mm, '/', yy, ' ', HH, ':', nn]);

    ///////////
    final moeda = NumberFormat.simpleCurrency(locale: 'pt_BR');
    //////
    return Card(
      child: Row(
        children: [
          _statusPedido(e),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Text(dataFormatada,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                      SizedBox(width: 10),
                      Text(moeda.format(e.totalFinal),
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Divider(),
                  //SizedBox(height: 3),
                  _produtos(e.prods),
                  _botaoVerDetalhes(e.idPedido),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _botaoVerDetalhes(String idPedido) {
    return Container(
      height: 30,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FlatButton(
            onPressed: () => Modular.to.pushNamed('pedido/$idPedido'),
            child: Text(
              'DETALHES',
              style: TextStyle(fontSize: 14, color: Colors.blueAccent),
            ),
          ),
        ],
      ),
    );
  }

  StreamBuilder<DocumentSnapshot> _statusPedido(MeuPedido e) {
    ////
    return StreamBuilder<DocumentSnapshot>(
      stream: controller.streamPedidoUnico(e.idPedido),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: exibeCarregandoCircular());
        }
        if (snapshot.hasError) {
          return Center(child: Text('ER!'));
        }
        if (!snapshot.hasData) {
          return Center(child: Text('N'));
        }
        if ((snapshot.data.data) == null) {
          return Center(child: Text('N1'));
        }
        if ((snapshot.data?.data['status'] ?? null) == null) {
          return Center(child: Text('N2'));
        }
        /////////////////////////////////////////
        var status = snapshot.data.data['status'];
        return Padding(
          padding: const EdgeInsets.all(4.5),
          child: StatusPedido(status),
        );
        /////////////////////////////////////////
      },
    );
  }

  Widget _produtos(List<String> prods) {
    return Wrap(
      direction: Axis.horizontal,
      children: prods
          .map(
            (e) => Row(
              //mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 5),
                Icon(
                  FontAwesomeIcons.dotCircle,
                  color: Theme.of(context).accentColor,
                  size: 10,
                ),
                SizedBox(width: 3),
                Text(e, overflow: TextOverflow.fade),
              ],
            ),
          )
          .toList(),
    );
  }
}
