import 'package:MeuPedido/app/modules/carrinho/carrinho_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';

class PainelEnderecos extends StatefulWidget {
  @override
  PainelEnderecosState createState() => PainelEnderecosState();
}

class PainelEnderecosState extends State<PainelEnderecos> {
  final CarrinhoController _carrinhoController =
      Modular.get<CarrinhoController>();

  @override
  void initState() {
    _carrinhoController.getEnderecos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      if (_carrinhoController.tipoEntrega == 'RET') return Container();
      return Container(
        //padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(top: 0, left: 15, right: 5),
              child: _tituloEndereco(),
            ),
            !((_carrinhoController.enderecos?.length ?? 0) > 0)
                ? Container(
                    padding: EdgeInsets.all(20),
                    child: Text('Cadastre um endereço'),
                  )
                : Column(
                    // shrinkWrap: true,
                    children: _carrinhoController.enderecos
                        .map(
                          (end) => RadioListTile(
                            activeColor: Theme.of(context).accentColor,
                            title: _cardEndereco(end),
                            groupValue: _carrinhoController.idEndereco,
                            value: end.docId,
                            onChanged: _carrinhoController.setCodEndereco,
                          ),
                        )
                        .toList(),
                  ),
          ],
        ),
      );
    });
  }

  Widget _btnExcluirEndereco(EnderecoModel end) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.trashAlt,
        size: 18,
        color: Colors.grey,
      ),
      onPressed: () async {
        if (await showPergunta(
              title: "Excluir este endereço?",
              desc: "${end.logradouro}",
              context: context,
            ) ==
            false) return;

        _carrinhoController.excluiEndereco(end);
      },
    );
  }

  Widget _btnAlterarEndereco(EnderecoModel end) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.edit,
        size: 18,
        color: Colors.grey,
      ),
      onPressed: () async {
        await Modular.to
            .pushNamed('endereco/edit', arguments: {"endereco": end});
        setState(() {});
        //await _carrinhoController.getEnderecos();
      },
    );
  }

  Card _cardEndereco(EnderecoModel end) {
    var lograd = '${end.logradouro} , ${end.numero}';
    if (end.complemento.isNotEmpty) lograd += '\n${end.complemento}';
    //
    return Card(
      shadowColor: Theme.of(context).accentColor,
      elevation: _carrinhoController.idEndereco == end.docId ? 4 : 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(6, 6, 0, 6),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(lograd),
                Text('Bairro: ${end.bairro}'),
                Text('CEP: ${end.cep}'),
              ],
            ),
            Positioned(
              bottom: -10,
              right: -5,
              child: _btnExcluirEndereco(end),
            ),
            Positioned(
              bottom: -10,
              right: 28,
              child: _btnAlterarEndereco(end),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tituloEndereco() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Selecione seu endereço:'),
        TextButton(
          onPressed: () async {
            var ret = await Modular.to.pushNamed('endereco/novo');

            if (ret != null && ret != '') {
              await _carrinhoController.getEnderecos();
              _carrinhoController.setCodEndereco(ret);
            }
          },
          child: Text(
            'Cadastrar novo...',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
        ),
      ],
    );
  }
}
