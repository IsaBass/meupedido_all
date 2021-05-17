import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'usuarios_controller.dart';
import 'usuarios_module.dart';

class UsuariosPage extends StatefulWidget {
  final String title;
  final String cnpj;
  const UsuariosPage({Key key, this.title = "Usuarios", this.cnpj})
      : super(key: key);

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  UsuariosController _controller = UsuariosModule.to.get<UsuariosController>();
  AuthController _authController = AppModule.to.get();

  @override
  void initState() {
    carregaLista();

    super.initState();
  }

  void carregaLista() async {
    await _controller.getAllUsuarios(widget.cnpj);
  }

  String getSitAtual(UserModel usu) {
    String sitAtual = '';
    if (usu.empresas != null)
      // for (var i = 0; i < usu.empresas.length; i++) {
      //   if (usu.empresas[i].cnpj == widget.cnpj)
      sitAtual = usu.empresas[usu.idxEmpresaAtual].status;
    // }

    switch (sitAtual) {
      case 'BLOCK':
        sitAtual = 'Bloqueado';
        break;
      case 'OK':
        sitAtual = 'Ativo';
        break;
      default:
        sitAtual = 'Pendente';
    }

    return sitAtual;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () =>
                Modular.to.pushNamedAndRemoveUntil('/home', (route) => false),
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: carregaLista,
          )
        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: MyConst.boxConstraints,
          child: Observer(builder: (context) {
            return Column(
              children: <Widget>[
                exibeCarregandoLinha(isLoading: _controller.isLoading),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: _controller.listaUsuarios
                        .map((usu) => _cardUsuario(usu, context))
                        .toList(),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Padding _cardUsuario(UserModel usu, BuildContext context) {
    String statusEmp = usu.empresas[usu.idxEmpresaAtual].status;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: statusEmp == 'BLOCK'
              ? Icon(Icons.block)
              : Icon(Icons.person,
                  color: statusEmp == 'OK' ? Colors.green : Colors.yellow),
          title: Text(usu.nome),
          subtitle: Text('Perfil: ${usu.perfilString()} '),
          trailing: IconButton(
            icon: Icon(Icons.speaker_notes),
            onPressed: () => exibirBotPanelUsuario(context, usu),
          ),
        ),
      ),
    );
  }

  exibirBotPanelUsuario(BuildContext ctx, UserModel usu) {
    ///
    return showBottomSheet(
        context: ctx,
        elevation: 20,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        builder: (context) {
          return ConstrainedBox(
            constraints: MyConst.boxConstraints,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _barrinhaSuperiorBottnSheet(context, usu),
                _botPanelContent(usu),
              ],
            ),
          );
        });
  }

  Widget _barrinhaSuperiorBottnSheet(BuildContext context, UserModel usu) {
    //
    void _clickSalvar() async {
      await _controller.salvarUser(usu);
      mySnackBar(context, texto: 'Salvo com sucesso', color: Colors.indigo);
      Navigator.of(context).pop();
    }

    return Container(
       height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
     
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Text(
                '  ${usu.nome} ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              )),
          Expanded(
            flex: 1,
            child: Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: _controller.isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white)))
                    : RaisedButton.icon(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: _clickSalvar,
                        icon: Icon(Icons.save),
                        label: Text('Salvar'),
                      ),
              );
            }),
          )
        ],
      ),
    );
  }

  Widget _botPanelContent(UserModel usu) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              // 'Data de Nascimento: ${formatDate(usu.dataNascimento, MyConst.formatacaoData)}',
              'Data de Nascimento: ${(DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'pt_Br').format(usu.dataNascimento))}',
              textAlign: TextAlign.start,
            ),
            Text(
              'E-mail: ${usu.email}',
              textAlign: TextAlign.start,
            ),
            _dropdownBPerfil(usu),
            _dropdownBSituacao(usu),
          ],
        ),
      ),
    );
  }

  Widget _dropdownBSituacao(UserModel usu) {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Situação: ${getSitAtual(usu)}'),
          SizedBox(width: 12),
          usu.empresas[usu.idxEmpresaAtual].status == 'OK'
              ? RaisedButton(
                  child: Text('Bloquear'),
                  color: Colors.red,
                  onPressed: usu.email == _authController.userAtual.email
                      ? null
                      : () => _controller.setStatusEmpresa(usu, 'BLOCK'),
                )
              : RaisedButton(
                  child: Text('Ativar'),
                  color: Colors.green,
                  onPressed: usu.email == _authController.userAtual.email
                      ? null
                      : () => _controller.setStatusEmpresa(usu, 'OK'),
                )
        ],
      );
    });
  }

  Widget _dropdownBPerfil(UserModel usu) {
    bool notNull(Object o) => o != null;

    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Perfil do usuário:'),
          SizedBox(width: 12),
          usu.email == _authController.userAtual.email
              ? Text(usu.perfilString())
              : DropdownButton(
                  elevation: 10,
                  value: usu.perfil,
                  items: [
                    DropdownMenuItem(
                        value: Perfil.normal, child: Text('Normal')),
                    DropdownMenuItem(
                        value: Perfil.superv, child: Text('Supervisor')),
                    DropdownMenuItem(
                        value: Perfil.master, child: Text('Master')),
                    (_authController.userAtual.perfil == Perfil.dev)
                        ? DropdownMenuItem(
                            value: Perfil.dev,
                            child: Text(
                              'dev',
                              style: TextStyle(color: Colors.red),
                            ))
                        : null,
                  ].where(notNull).toList(),
                  onChanged: (value) {
                    _controller.setPerfil(usu, value);
                    // usu.perfil = value;
                    // _controller.listaUsuarios = _controller.listaUsuarios;
                  },
                ),
        ],
      );
    });
  }
}

// DropdownButton(
//   elevation: 10,
//   value: usu.empresas[usu.idxEmpresaAtual].status,
//   items: [
//     DropdownMenuItem(value: 'OK', child: Text('Ativo')),
//     DropdownMenuItem(value: 'PEND', child: Text('Pendente')),
//     DropdownMenuItem(value: 'BLOCK', child: Text('Bloqueado')),
//   ],
//   onChanged: (value) => _controller.setStatusEmpresa(usu, value),
// ),
