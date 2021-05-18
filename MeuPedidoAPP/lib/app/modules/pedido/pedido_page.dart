// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'pedido_controller.dart';

class PedidoPage extends StatefulWidget {
  final String idPedido;
  final String title;
  const PedidoPage({Key key, this.title = "Pedido", this.idPedido})
      : super(key: key);

  @override
  _PedidoPageState createState() => _PedidoPageState();
}

class _PedidoPageState extends ModularState<PedidoPage, PedidoController> {
  //
  TextEditingController _motivoCancelController = TextEditingController();
  final moeda = NumberFormat.simpleCurrency(locale: 'pt_BR');
  //

  @override
  void initState() {
    super.initState();
    controller.getPedido(widget.idPedido);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: <Widget>[
              _builderPedido(),
              SizedBox(height: 10),
              Text('Pedido id: ${widget.idPedido}',
                  style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _builderPedido() {
    return Observer(
      builder: (_) {
        print('entrou no builder do Observer');

        if ((controller.pedido?.data ?? null) == null) {
          return Center(child: Text('Pedido Não encontrado!'));
        }

        if (controller.pedido?.hasError ?? true) {
          return Center(child: Text('Ocorreu um erro na requisição'));
        }

        var ped = controller.pedido.value;
        if (ped == null || ped.length == 0) {
          return Center(child: Text('Pedido Não encontrado!'));
        }

        ///////////////////
        Pedido pedido = Pedido.fromJson(ped);
        pedido.docId = ped['docID'];

        return Column(
          children: [
            _cardCabecalhoPedido(pedido, moeda),
            _cardEntrega(pedido),
            _cardProdutos(pedido),
            _cardPedirCancelamento(pedido)
          ],
        );
        /////////////////
      },
    );
  }

  // Widget _builderPedido() {
  //   return StreamBuilder<Map<String, dynamic>>(
  //     stream: controller.pedido, //controller.getPedido(widget.idPedido),
  //     builder: (_, snapshot) {
  //       print(' builder do stream ');
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Center(child: exibeCarregandoCircular());
  //       }
  //       if (snapshot.hasError) {
  //         return Center(child: Text('Ocorreu um erro na requisição'));
  //       }
  //       if (!snapshot.hasData) {
  //         return Center(child: Text('Pedido Não encontrado!'));
  //       }
  //       if ((snapshot.data) == null) {
  //         return Center(child: Text('Pedido Não encontrado!'));
  //       }

  //       ///////////////////
  //       Pedido pedido = Pedido.fromJson(snapshot.data);
  //       pedido.docId = snapshot.data['docID'];

  //       return Column(
  //         children: [
  //           _cardCabecalhoPedido(pedido, moeda),
  //           _cardEntrega(pedido),
  //           _cardProdutos(pedido),
  //           _cardPedirCancelamento(pedido)
  //         ],
  //       );
  //       /////////////////
  //     },
  //   );
  // }

  Card _cardCabecalhoPedido(Pedido pedido, NumberFormat moeda) {
    ////////
    String _formataData(int data) {
      return DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'pt_Br')
          .format(DateTime.fromMillisecondsSinceEpoch(data));
    }

    var dataFormatada = _formataData(pedido.dataHora);
    // formatDate(
    //     DateTime.fromMillisecondsSinceEpoch(pedido.dataHora),
    //     [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);

    ///////////
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pedido: ${pedido.codpedido}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text('Data: $dataFormatada', style: TextStyle(fontSize: 15)),
                  Text('Valor Total: ${moeda.format(pedido.totalFinal)}'),
                  Divider(thickness: 1),
                  Text(
                      "Forma de Pagamento: ${(pedido.pagamentos[0].forma == 'INLOCO') ? 'Na Entrega' : 'On-Line'}"),
                  (pedido.pagamentos[0].codPag.toUpperCase() ==
                          'MercadoPago'.toUpperCase())
                      ? Text("Mercado Pago")
                      : (pedido.pagamentos[0].codPag.toUpperCase() ==
                              'cielo'.toUpperCase())
                          ? Text("Cielo")
                          : Container(),
                  Text('Pagamento: ' + pedido.pagamentos[0].descricao),
                  (pedido.pagamentos[0].bandeira ?? '').isEmpty
                      ? Container()
                      : Text('Cartão: ' + pedido.pagamentos[0].bandeira),
                  (pedido.pagamentos[0].codAutorizacao ?? '').isEmpty
                      ? Container()
                      : Text('Autorização: ' +
                          pedido.pagamentos[0].codAutorizacao),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: StatusPedido(pedido.status),
          ),
        ],
      ),
    );
  }

  Card _cardProdutos(Pedido pedido) {
    ////////////

    Widget _adicionais(List<AdicionalPedidoModel> adics) {
      //////
      String _getVlrAdic(AdicionalPedidoModel ad) {
        if (ad.valorUnit == null || ad.valorUnit == 0.0) return "";
        return '(' + moeda.format(ad.valorUnit) + ')';
      }

      //////
      return Wrap(
        direction: Axis.horizontal,
        children: adics
            .map(
              (e) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: 5),
                  Icon(
                    FontAwesomeIcons.dotCircle,
                    color: Theme.of(context).accentColor,
                    size: 10,
                  ),
                  SizedBox(width: 3),
                  Text(
                      ' + ${e.quantidade.toStringAsFixed(0)} ${e.descricao} ${_getVlrAdic(e)}  '),
                ],
              ),
            )
            .toList(),
      );
    }

    int ct = 0;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: pedido.prods.map((prod) {
            ct++;
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${prod.descricao}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  Text("Quantidade: ${prod.quantidade.toString()}"),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Valor Unit: ${moeda.format(prod.vlrUnit)}"),
                      ((prod.vlrAdics ?? 0.0) > 0.0)
                          ? SizedBox(width: 20)
                          : Container(),
                      ((prod.vlrAdics ?? 0.0) > 0.0)
                          ? Text("Adicionais: ${moeda.format(prod.vlrAdics)}")
                          : Container(),
                    ],
                  ),
                  Text(
                    "Valor Total: ${moeda.format(prod.quantidade * (prod.vlrUnit + (prod.vlrAdics ?? 0.0)))}",
                  ),
                  SizedBox(height: 4),
                  _adicionais(prod.adics),
                  pedido.prods.length == ct
                      ? SizedBox(height: 10)
                      : Divider(thickness: 1),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
    ///////////////
  }

  Card _cardEntrega(Pedido pedido) {
    ////////////

    String descTipoEntrega() {
      switch (pedido.tipoEntrega) {
        case "FRETE":
          return "Delivery";
          break;
        case "RET":
          return "Retirada Balcão";
          break;
        default:
          return "Não informado";
      }
    }

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Tipo Entrega: ${descTipoEntrega()}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            pedido.tipoEntrega == 'RET'
                ? Container()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          "${(pedido.endereco?.logradouro ?? '')} , ${(pedido.endereco?.numero ?? '')} "),
                      (pedido.endereco?.complemento?.isNotEmpty ?? false)
                          ? Text("${(pedido.endereco?.complemento ?? '')}")
                          : Container(),
                      Text("Bairro: ${(pedido.endereco?.bairro ?? '')}"),
                      Text(
                          "Cidade: ${(pedido.endereco?.cidade ?? '')}-${(pedido.endereco?.uf ?? '')}"),
                    ],
                  ),
          ],
        ),
      ),
    );
    ///////////////
  }

  Widget _cardPedirCancelamento(Pedido pedido) {
    ////////////

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        //width: double.infinity,
        //padding: const EdgeInsets.fromLTRB(15, 8, 5, 8),
        child: ExpansionTile(
          leading: Icon(Icons.cancel),
          title: Text("Solicitar Cancelamento"),
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              //margin: EdgeInsets.fromLTRB(10, 0, 10, 8),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: TextFormField(
                  controller: _motivoCancelController,
                  maxLines: 3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    filled: true,
                    //icon: Icon(FontAwesomeIcons.moneyCheckAlt),
                    hintText: 'Descreva o motivo para cancelamento',
                    labelText: 'Motivo do cancelamento',
                    // helperText: widget.helperText,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                      '*1: pedidos já aceitos dependerão do cancelmento da loja;'),
                  Text(
                      '*2: caso pagamento por cartão de débito, entre em contato com o atendimento para efetuar o devido estorno'),
                ],
              ),
            ),
            ButtonBar(
              children: [
                TextButton(
                    onPressed: () => _motivoCancelController.text = '',
                    child: Text('Desistir')),
                TextButton(
                  child: Text('Pedir Cancelamento'),
                  onPressed: () => botaoCancelamento(pedido),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    ///////////////
  }

  void botaoCancelamento(Pedido pedido) async {
    ///
    if (_motivoCancelController.text.length < 10) {
      await showPergunta(
          title: '',
          desc: 'Descreva melhor o Motivo de Cancelamento.',
          botaoNao: 'OK',
          botaoSim: '',
          context: context);
      return;
    }

    ///
    var perg = await showPergunta(
        title: 'Confirma Pedido de Cancelamento?', context: context);
    if (perg != true) return;

    ///
    var resp = await controller.pedirCancelamento(
        pedido, _motivoCancelController.text);
    if (resp['resposta'] == 'NEGADO') {
      await showPergunta(
        title: 'Não Cancelado',
        desc: 'Não conseguimos realizar o cancelamento.\n'
            'Por favor entre em contato com o atendimento.',
        botaoNao: 'OK',
        botaoSim: '',
        context: context,
      );
      //
    }
    if (resp['resposta'] == 'pendente') {
      await showPergunta(
        title: 'Cancelamento Pendente',
        desc: 'Seu pedido de cancelemnto será analisado pelo atendimento.'
            'Aguarde nossa mensagem de confirmação',
        botaoNao: 'OK',
        botaoSim: '',
        context: context,
      );
      //
      return Modular.to.pop();
    }
    if (resp['resposta'] == 'success') {
      await showPergunta(
        title: '',
        desc: 'Cancelamento efetuado com sucesso.',
        botaoNao: 'OK',
        botaoSim: '',
        context: context,
      );
      //
      return Modular.to.pop();
    }
    //////
  }
}
