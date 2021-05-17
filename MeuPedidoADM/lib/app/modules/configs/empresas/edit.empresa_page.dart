import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedidoADM/app/modules/configs/widgets/widgets.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'empresas_controller.dart';
import 'empresas_module.dart';

class EditEmpresaPage extends StatefulWidget {
  final CnpjModel empresa;
  final Function funcSalvar;

  final String title;
  const EditEmpresaPage(
      {Key key,
      this.title = 'Alterando Empresa',
      @required this.empresa,
      this.funcSalvar})
      : super(key: key);

  @override
  _EditEmpresaPageState createState() => _EditEmpresaPageState();
}

class _EditEmpresaPageState extends State<EditEmpresaPage> {
  EmpresasController controller = EmpresasModule.to.get();
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeCont = TextEditingController();
  final TextEditingController _cchaveCont = TextEditingController();
  final TextEditingController _cnpjCont = TextEditingController();

  @override
  void initState() {
    super.initState();

    _nomeCont.text = widget.empresa.descricao;
    _cchaveCont.text = widget.empresa.cChave;
    _cnpjCont.text = widget.empresa.docId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          title: Text(
              widget.empresa.docId == null || widget.empresa.docId.isEmpty
                  ? 'Nova Empresa'
                  : widget.empresa.descricao)),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: MyConst.boxConstraints,
          child: _bodyEdicao(widget.empresa, context),
        ),
      ),
    );
  }

  Widget _bodyEdicao(CnpjModel emp, BuildContext ctx) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nomeCont,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.business),
                  hintText: 'Nome da Empresa',
                  labelText: 'Nome *',
                ),
                validator: (v) {
                  if (!(v.length >= 8)) return 'nome muito curto';
                  return null;
                },
              ),
              SizedBox(height: 7),
              TextFormField(
                controller: _cnpjCont,
                enabled: widget.empresa.docId == null ||
                    widget.empresa.docId.isEmpty,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: FaIcon(FontAwesomeIcons.receipt, size: 30),
                  hintText: 'CNPJ da Empresa',
                  labelText: 'CNPJ *',
                ),
                validator: (v) {
                  if (!(v.length >= 11)) return 'CNPJ Necessário';
                  return null;
                },
              ),
              SizedBox(height: 7),
              TextFormField(
                controller: _cchaveCont,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  filled: true,
                  icon: FaIcon(FontAwesomeIcons.shieldAlt),
                  hintText: 'CCHAVE de Registro',
                  labelText: 'CCHAVE *',
                ),
                validator: (v) {
                  if (!(v.length >= 6)) return 'Campo Necessário';
                  return null;
                },
              ),
              // : Container(height: 0)   ,
              _empresaAtiva(emp),
              //Divider(),
              //_empresaTipo(emp),

              // _quadroFiliais(emp),
              const SizedBox(height: 7),
              _botaoSalvar(emp, widget.funcSalvar),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _quadroFiliais(CnpjModel emp) {
  //   if (emp.tipo == 'LOJA') return Container(height: 0);

  //   return Container(
  //     decoration: BoxDecoration(
  //       border: Border.all(color: Colors.grey),
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     child: Column(
  //       children: <Widget>[
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 8),
  //           width: double.infinity,
  //           height: 32,
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               Text(
  //                 'Filiais:',
  //                 style: TextStyle(
  //                     color: Colors.white,
  //                     fontSize: 17,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //               GestureDetector(
  //                 child: Icon(
  //                   Icons.add,
  //                   color: Colors.white,
  //                   size: 35,
  //                 ),
  //                 onTap: () {
  //                   Filial f = Filial(
  //                     cnpj: '',
  //                     descricao: '',
  //                     descReduz: '',
  //                     ativo: true,
  //                     visivel: true,
  //                   );
  //                   Modular.to.pushNamed('/configs/empresas/filial',
  //                       arguments: {
  //                         "emp": emp,
  //                         "filial": f,
  //                         "func": funcaoSalvaNovaFilial
  //                       });

  //                   // showCadastraFilial(context, emp);
  //                 },
  //               ),
  //             ],
  //           ),
  //           decoration: BoxDecoration(
  //               color: Colors.grey, borderRadius: BorderRadius.circular(10)),
  //         ),
  //         ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: emp.dadosFiliais.length,
  //           itemBuilder: (ctx, idx) => ListTile(
  //             title: Text(emp.dadosFiliais[idx].descricao),
  //             subtitle: Text(emp.dadosFiliais[idx].cnpj),
  //             trailing: IconButton(
  //                 icon: FaIcon(FontAwesomeIcons.edit ),
  //                 onPressed: () async {

  //                   Modular.to.pushNamed('/configs/empresas/filial',
  //                       arguments: {
  //                         "emp": emp,
  //                         "filial": emp.dadosFiliais[idx],
  //                         "func": (CnpjModel emp, Filial fil) {
  //                           setState(() {

  //                           });
  //                         }
  //                       });

  //                   // await showPerguntaExclusaoFilial(
  //                   //   desc:  emp.dadosFiliais[idx].descricao,
  //                   //   context: ctx,
  //                   //   funcSim: () => setState(
  //                   //     () => emp.dadosFiliais.remove(emp.dadosFiliais[idx]),
  //                   //   ));
  //                 }),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _botaoSalvar(CnpjModel emp, Function func) {
    return Observer(builder: (_) {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : RaisedButton.icon(
                icon: Icon(Icons.save),
                textColor: Colors.white,
                onPressed: () async {
                  if (!_formKey.currentState.validate()) return;

                  emp.descricao = _nomeCont.text;
                  emp.cChave = _cchaveCont.text;
                  if (emp.docId == null || emp.docId.isEmpty)
                    emp.docId = _cnpjCont.text;

                  func(emp);

                  Modular.to.pop();
                },
                color: Theme.of(context).primaryColor,
                label: Text('Salvar'),
              ),
      );
    });
  }

  // Widget _empresaTipo(CnpjModel emp) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 10),
  //     child: Row(
  //       children: <Widget>[
  //         const Text('Tpo: '),
  //         const SizedBox(width: 20),
  //         Row(
  //           children: <Widget>[
  //             const Text('CENTRAL'),
  //             Radio<String>(
  //               value: 'CENTRAL',
  //               groupValue: emp.tipo,
  //               onChanged: (t) => setState(() => emp.tipo = t),
  //             ),
  //           ],
  //         ),
  //         Row(
  //           children: <Widget>[
  //             const Text('LOJA'),
  //             Radio<String>(
  //               value: 'LOJA',
  //               groupValue: emp.tipo,
  //               onChanged: (t) => setState(() => emp.tipo = t),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Container _empresaAtiva(CnpjModel emp) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: <Widget>[
          const Text('Emprasa Ativa?'),
          SizedBox(width: 20),
          CupertinoSwitch(
            trackColor: Colors.red,
            value: emp.ativo,
            onChanged: (v) => setState(() => emp.ativo = v),
          ),
        ],
      ),
    );
  }

  Future<bool> showPerguntaExclusaoFilial(
      {String desc, BuildContext context, Function funcSim}) async {
    return await Alert(
      context: context,
      type: AlertType.warning,
      title: desc,
      desc: "Confirma exclusão desta filial?",
      buttons: [
        DialogButton(
          width: 120,
          child: Text(
            "EXCLUIR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);

            funcSim();
          },
        ),
        DialogButton(
          child: Text(
            "VOLTAR",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            Navigator.pop(context);
            return false;
          },
          width: 120,
        ),
      ],
    ).show();
  }

  Future<bool> showCadastraFilial(BuildContext context, CnpjModel emp) async {
    TextEditingController textEditingController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    //String descFilial;

    return await Alert(
      context: context,
      type: AlertType.none,
      title: 'Registrar Filial',
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              ' CNPJ da Filial',
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

            // if (emp.filiais == null) {
            //   emp.filiais = [];
            //   emp.dadosFiliais = [];
            // }

            // var d = await _cnpjController
            //     .getDescricaoCnpj(textEditingController.text);

            // setState(() {
            //   // emp.filiais.add(textEditingController.text);
            //   emp.dadosFiliais
            //       .add(Filial(cnpj: textEditingController.text, descricao: d));
            // });

            Navigator.pop(context);

            // mySnackBar(context,
            //     texto: "Adicionado com sucesso",
            //     color: Colors.indigo[900],
            //     miliseconds: 1500);
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

  // funcaoSalvaNovaFilial(CnpjModel emp, Filial fil) {
  //   setState(() {
  //     emp.dadosFiliais.add(fil);
  //   });
  // }
}

// Container(
//   width: MediaQuery.of(context).size.width,
//   padding: EdgeInsets.all(4),
//   child: RaisedButton(
//     color: Theme.of(context).primaryColor,
//     child: _authController.isLoading == true
//         ? Center(
//             child: CircularProgressIndicator(),
//           )
//         : Text(
//             'Cadastrar',
//             style: TextStyle(color: Colors.white),
//           ),
//     onPressed: () {
//       if (_formKey.currentState.validate()) {
//         _authController.userAtual.nome = _nomeCont.text;
//         _authController.userAtual.email = _emailCont.text;
//         _authController.createLoginEmailSenha(
//             pass: _senhaCont.text,
//             onFail: _onFail,
//             onSucces: _onSucces);
//       }
//     },
//   ),
// ),
