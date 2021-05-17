import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedido_core/meupedido_core.dart';

class PainelAdicional extends StatefulWidget {
  ///
  final List<AdicionalGrpModel> grupoAdicionais;
  final Function atualizeAlgo;
  //

  const PainelAdicional({Key key, this.grupoAdicionais, this.atualizeAlgo})
      : super(key: key);

  @override
  _PainelAdicionalState createState() => _PainelAdicionalState();
}

class _PainelAdicionalState extends State<PainelAdicional> {
  ///
  final formatMoeda = NumberFormat.simpleCurrency(locale: 'pt_BR');

  void atualize() {
    if (widget.atualizeAlgo != null) widget.atualizeAlgo();
  }

  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: widget.grupoAdicionais
          .map(
            (grupo) => Card(
              child: ExpansionTile(
                title: Text("${grupo.origem} - ${grupo.descricao}"),
                children: [
                  Column(
                    children: grupo.adics
                        .map(
                          (ad) => Container(
                            padding: EdgeInsets.fromLTRB(8, 0, 5, 0),
                            height: 28,
                            width: double.infinity,
                            child: _linhaAdicional(ad),
                          ),
                        )
                        .toList(),
                  ),
                  _botaoInferior(context, grupo),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Align _botaoInferior(BuildContext ctx, AdicionalGrpModel grupo) {
    return Align(
      alignment: Alignment.topRight,
      child: FlatButton(
        child: Text('ALTERAR'),
        onPressed: () {
          Modular.to.pushNamed('altAdicionais', arguments: {'grupo': grupo});
        },
      ),
    );
  }

  Row _linhaAdicional(AdicionalModel ad) => Row(
        children: [
          Switch(
            value: ad.checked,
            onChanged: (v) => setState(() => ad.checked = v),
          ),
          Text('${ad.descricao}  (${formatMoeda.format(ad.preco)})'),
        ],
      );

  // Container _tituloGrupo(AdicionalGrpModel grupo) {
  //   return Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
  //     height: 18,
  //     child: Row(
  //       children: [
  //         Text(
  //           grupo.descricao,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  //         ),
  //         SizedBox(width: 10),
  //         (grupo.minQtd > 0 && grupo.validado)
  //             ? Icon(Icons.check, color: Colors.green)
  //             : Container()
  //       ],
  //     ),
  //   );
  // }

  // Widget _opQtd(AdicionalGrpModel grupo, AdicionalModel ad, BuildContext ctx) {
  //   return Container(
  //     // constraints: BoxConstraints(
  //     //   minHeight: 10
  //     // ),
  //     //height: 32,
  //     child: Row(
  //       //alignment: Alignment.center,
  //       children: [
  //         Expanded(
  //           child: Padding(
  //             padding: const EdgeInsets.only(left: 12.0),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 // TextEd
  //                 Text(
  //                   '${ad.descricao}',
  //                   style: TextStyle(fontSize: 16),
  //                   maxLines: 3,
  //                   overflow: TextOverflow.fade,
  //                 ),
  //                 (ad.preco > 0)
  //                     ? Text(
  //                         ' ${grupo.determinaPreco ? '=' : '+'} ${formatMoeda.format(ad.preco)}',
  //                         style:
  //                             TextStyle(fontSize: 15, color: Colors.grey[600]),
  //                       )
  //                     : Container(),
  //               ],
  //             ),
  //           ),
  //         ),
  //         (grupo.minQtd == 1 && grupo.maxQtd == 1)
  //             ? Radio(
  //                 groupValue: grupo.valorAtual,
  //                 value: ad.valor,
  //                 activeColor: Theme.of(ctx).accentColor,
  //                 onChanged: (value) {
  //                   setState(() {
  //                     grupo.valorAtual = value;
  //                     atualize();
  //                   });
  //                 })
  //             : Container(
  //                 //width: 150,
  //                 child: Row(
  //                   crossAxisAlignment: CrossAxisAlignment.center,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     (ad.quantidade > 0)
  //                         ? IconButton(
  //                             icon: Icon(Icons.remove_circle_outline, size: 30),
  //                             onPressed: () {
  //                               setState(() {
  //                                 if (ad.quantidade > 0) ad.quantidade--;
  //                                 atualize();
  //                               });
  //                             })
  //                         : Container(),
  //                     Text(
  //                       '${ad.quantidade.toStringAsFixed(0)}',
  //                       style: TextStyle(
  //                         fontSize: 25,
  //                         // color: ad.quantidade > 0
  //                         //     ? Theme.of(context).primaryColor
  //                         //     : Colors.grey
  //                       ),
  //                     ),
  //                     IconButton(
  //                         icon: Icon(Icons.add_circle_outline, size: 30),
  //                         onPressed: (grupo.qtdSelecionada >= grupo.maxQtd)
  //                             ? null
  //                             : () {
  //                                 setState(() {
  //                                   ad.quantidade++;
  //                                   atualize();
  //                                 });
  //                               }),
  //                   ],
  //                 ),
  //               ),
  //       ],
  //     ),
  //   );
  // }

  // Widget opcionais(AdicionalGrpModel grupo, BuildContext ctx) => Column(
  //     children: grupo.adics
  //         .map(
  //           (ad) =>
  //               // grupo.tipoEscolha != 'Q'
  //               //     ? Stack(
  //               //         children: <Widget>[
  //               //           Container(
  //               //             constraints: BoxConstraints(
  //               //               maxHeight: 30
  //               //             ),
  //               //             child: Row(
  //               //               children: <Widget>[
  //               //                 grupo.tipoEscolha != 'U'

  //               //                     : _opUnica(grupo, ad, ctx),
  //               //                 Text(ad.descricao),
  //               //               ],
  //               //             ),
  //               //           ),
  //               //           Positioned(
  //               //               right: 10,
  //               //               child: Text('R\$ ' + ad.preco.toStringAsFixed(2))),
  //               //         ],
  //               //       )
  //               // :
  //               _opQtd(grupo, ad, ctx),
  //         )
  //         .toList());

  // Radio<String> _opUnica(
  //     AdicionalGrpModel grupo, AdicionalModel ad, BuildContext ctx) {
  //   return Radio(
  //       groupValue: grupo.valorAtual,
  //       value: ad.valor,
  //       activeColor: Theme.of(ctx).primaryColor,
  //       onChanged: (value) {
  //         setState(() {
  //           grupo.valorAtual = value;
  //         });
  //       });
  // }

  // Checkbox _opCheckBox(AdicionalModel ad, BuildContext ctx) {
  //   return Checkbox(
  //       value: ad.checked,
  //       checkColor: Theme.of(ctx).accentColor,
  //       activeColor: Theme.of(ctx).primaryColor,
  //       onChanged: (value) {
  //         setState(() {
  //           ad.checked = value;
  //         });
  //       });
  // }
}
