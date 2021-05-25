import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/utils/janela.pergunta.dart';

import 'list_enderecos_controller.dart';

class PerfilListaEnderecos extends StatefulWidget {
  @override
  PerfilListaEnderecosState createState() => PerfilListaEnderecosState();
}

class PerfilListaEnderecosState
    extends ModularState<PerfilListaEnderecos, ListEnderecosController> {
  @override
  void initState() {
    controller.getEnderecos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Endereços'),
        ),
        body: Container(
          //padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 0, left: 15, right: 5),
                child: _tituloEndereco(),
              ),
              !((controller.enderecos?.length ?? 0) > 0)
                  ? Container(
                      padding: EdgeInsets.all(20),
                      child: Text('Cadastre um endereço'),
                    )
                  : Column(
                      // shrinkWrap: true,
                      children: controller.enderecos
                          .map((e) => _cardEndereco(e))
                          .toList(),
                    ),
            ],
          ),
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

        controller.excluiEndereco(end);
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
        // await Modular.to
        //     .pushNamed('endereco/edit', arguments: {"endereco": end});
        await Modular.to
            .pushNamed('/endereco/edit', arguments: {"endereco": end});
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
      elevation: 4,
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
        Text('Endereços cadastrados:'),
        TextButton(
          onPressed: () async {
            var ret = await Modular.to.pushNamed('/endereco/novo');

            if (ret != null && ret != '') {
              controller.getEnderecos();
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
