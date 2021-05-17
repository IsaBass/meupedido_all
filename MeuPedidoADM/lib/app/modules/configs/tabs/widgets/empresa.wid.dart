import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/modules/configs/widgets/widgets.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../configs_controller.dart';
import '../../configs_module.dart';

Future<bool> showCadastraEmpresa(BuildContext context) async {
  ConfigsController _controller = ConfigsModule.to.get<ConfigsController>();
  TextEditingController textEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  return await Alert(
    context: context,
    type: AlertType.none,
    title: 'Registrar-se em nova Empresa',
    content: Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            ' CNPJ da Empresa',
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          TextFormField(
            controller: textEditingController,
            decoration: inputDecoration(
                hintText: 'digite o CNPJ', helperText: 'somente números'),
            validator: (v) {
              if (v.isEmpty || v == null) return 'CNPJ inválido';
              return null;
            },
          ),
        ],
      ),
    ),
    buttons: [
      DialogButton(
        width: 120,
        child: Text(
          "Salvar",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate() == false) {
            return;
          }
          _controller.adicioneEmpresa(textEditingController.text, (texto) {
            _onFail(texto, context);
          }, () {
            Navigator.pop(context);

            mySnackBar(context,
                texto: "Adicionado com sucesso",
                color: Colors.indigo[900],
                miliseconds: 1500);
          });
        },
      ),
      DialogButton(
        child: Text(
          "Voltar",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      ),
    ],
  ).show();
}

void _onFail(String texto, BuildContext context) {
  Alert(
    context: context,
    title: texto,
    type: AlertType.error,
    buttons: [
      DialogButton(
          child:
              Text('OK', style: TextStyle(color: Colors.white, fontSize: 20)),
          onPressed: () => Navigator.of(context).pop())
    ],
  ).show();
}

Future<bool> showPerguntaExclusao(UserEmpresa e, BuildContext context) async {
  ConfigsController _controller = ConfigsModule.to.get<ConfigsController>();
  return await Alert(
    context: context,
    type: AlertType.warning,
    title: e.cnpjM.descricao,
    desc:
        "Confirma exclusão desta empresa da sua lista de empresas habilitadas?",
    buttons: [
      DialogButton(
        width: 120,
        child: Text(
          "EXCLUIR",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          _controller.excluiEmpresa(e);

          Navigator.pop(context);
        },
      ),
      DialogButton(
        child: Text(
          "VOLTAR",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        width: 120,
      ),
    ],
  ).show();
}

void showOptionsEmpresa(
    UserEmpresa e, BuildContext ctx, Perfil perfiUserAtual) {
  final ConfigsController _controller =
      ConfigsModule.to.get<ConfigsController>();

  showModalBottomSheet(
    context: ctx,
    builder: (context) {
      return ConstrainedBox(
        constraints: MyConst.boxConstraints,
        child: BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                color: Color(0xFF737373),
                child: Container(
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[800],
                        blurRadius: 10,
                        spreadRadius: 3,
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Opções para ${e.cnpjM.descricao}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Divider(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: _botaoExcluirEmpresa(
                                  ctx, e, perfiUserAtual)),
                          Expanded(
                              flex: 1,
                              child: _botaoTornarPadrao(ctx, e, _controller)),
                          Expanded(
                              flex: 1,
                              child: _botaoGerenciarUsuarios(
                                  ctx, e, _controller, perfiUserAtual)),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      );
    },
  );
}

Widget _botaoOpcaoInferior({IconData icon, String label, Function onPressed, @required BuildContext context}) {
  return Container(
    height: 70,
    margin: EdgeInsets.all(5),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey[800],
            blurRadius: 10,
            spreadRadius: 3,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: RaisedButton(
        //elevation: 10,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
             Icon(icon, size: 32, color: Colors.black),
            SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

Widget _botaoExcluirEmpresa(
    BuildContext context, UserEmpresa e, Perfil perfiUserAtual) {
  return _botaoOpcaoInferior(
    context: context,
    icon: (Icons.delete_forever),
    label: 'Excluir Empresa',
    onPressed: perfiUserAtual.index > 0
        ? () async {
            await showPerguntaExclusao(e, context);

            Navigator.pop(context);
          }
        : null,
  );
}

Widget _botaoTornarPadrao(
    BuildContext ctx, UserEmpresa e, ConfigsController controller) {
  return _botaoOpcaoInferior(
    context: ctx,
    icon: (Icons.assignment_turned_in),
    label: 'Tornar Padrão',
    onPressed: () async {
      await controller.tornarEmpresaPadrao(e.cnpjM.docId);

      mySnackBar(ctx, texto: ' ${e.cnpjM.descricao} tornou-se padrão');

      Navigator.pop(ctx);
    },
  );
}

Widget _botaoGerenciarUsuarios(BuildContext context, UserEmpresa e,
    ConfigsController controller, Perfil perfiUserAtual) {
  return _botaoOpcaoInferior(
    context: context,
    icon: (Icons.person_pin),
    label: 'Ver\nUsuários',
    onPressed: perfiUserAtual.index > 0
        ? () async {
            Navigator.pop(context);
            Modular.to.pushNamed('/configs/usuarios/${e.cnpjM.docId}');
          }
        : null,
  );
}
