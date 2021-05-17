// import 'package:estoquecentral/app/auth/models/cnpj_model.dart';
// import 'package:estoquecentral/app/modules/configs/empresas/empresas_controller.dart';
// import 'package:estoquecentral/app/modules/configs/empresas/empresas_module.dart';
// import 'package:estoquecentral/app/utils/constantes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class EditFilialPage extends StatefulWidget {
//   final CnpjModel empresa;
//   final Filial filial;
//   final Function funcSalvar;

//   final String title;
//   const EditFilialPage(
//       {Key key,
//       this.title = 'Nova Empresa Cliente',
//       this.empresa,
//       this.filial,
//       this.funcSalvar})
//       : super(key: key);

//   @override
//   _EditFilialPageState createState() => _EditFilialPageState();
// }

// class _EditFilialPageState extends State<EditFilialPage> {
//   EmpresasController controller = EmpresasModule.to.get();
//   var _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _nomeCont = TextEditingController();
//   final TextEditingController _cnpjCont = TextEditingController();
//   final TextEditingController _descRedzCont = TextEditingController();

//   @override
//   void initState() {
//     super.initState();

//     _nomeCont.text = widget.filial.descricao;
//     _descRedzCont.text = widget.filial.descReduz;
//     _cnpjCont.text = widget.filial.cnpj;

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(title: Text('Filial...')),
//       body: Align(
//         alignment: Alignment.topCenter,
//         child: ConstrainedBox(
//           constraints: MyConst.boxConstraints,
//           child: _bodyAdicao( widget.filial, context),
//         ),
//       ),
//     );
//   }

//   Widget _bodyAdicao(Filial filial, BuildContext ctx) {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Container(
//           padding: EdgeInsets.all(8),
//           child: Column(
//             children: <Widget>[
//               Container(
//                 child: Text('Filial de ${widget.empresa.descricao}'),
//               ),
//               SizedBox(height: 7),
//               TextFormField(
//                 controller: _nomeCont,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   filled: true,
//                   icon: Icon(Icons.business),
//                   hintText: 'Nome da Filial',
//                   labelText: 'Nome *',
//                 ),
//                 validator: (v) {
//                   if (!(v.length >= 8)) return 'nome muito curto';
//                   return null;
//                 },
//               ),
//               SizedBox(height: 7),
//               TextFormField(
//                 controller: _descRedzCont,
//                 keyboardType: TextInputType.text,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   filled: true,
//                   icon: Icon(Icons.business),
//                   hintText: 'Nome reduzido',
//                   labelText: 'Reduzido (2 a 6)*',
//                 ),
//                 validator: (v) {
//                   if ((v.length > 6)) return 'nome muito longo';
//                   if ((v.length < 2)) return 'nome muito curto';
//                   return null;
//                 },
//               ),
//               SizedBox(height: 7),
//               TextFormField(
//                 controller: _cnpjCont,
//                 keyboardType: TextInputType.number,
//                 decoration: const InputDecoration(
//                   border: UnderlineInputBorder(),
//                   filled: true,
//                   icon: FaIcon(FontAwesomeIcons.receipt, size: 30),
//                   hintText: 'CNPJ da Empresa',
//                   labelText: 'CNPJ *',
//                 ),
//                 validator: (v) {
//                   if (!(v.length >= 11)) return 'CNPJ Necessário';
//                   return null;
//                 },
//               ),
//               SizedBox(height: 7),

//               _filialAtiva(filial),
//               //Divider(),
//               _filialVisivel(filial),

//               const SizedBox(height: 7),
//               _botaoSalvar(filial),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _botaoSalvar( Filial filial) {

    
//     return Observer(builder: (_) {
//       return Container(
//         width: double.infinity,
//         padding: EdgeInsets.symmetric(horizontal: 5),
//         child: controller.isLoading
//             ? Center(child: CircularProgressIndicator())
//             : RaisedButton.icon(
//                 icon: Icon(Icons.save),
//                 textColor: Colors.white,
//                 onPressed: () async {
//                   if (!_formKey.currentState.validate()) return;

//                   filial.descricao = _nomeCont.text;
//                   filial.cnpj = _cnpjCont.text;
//                   filial.descReduz = _descRedzCont.text;

//                   widget.funcSalvar(widget.empresa, filial);

//                   Modular.to.pop();
//                 },
//                 color: Theme.of(context).primaryColor,
//                 label: Text('Salvar'),
//               ),
//       );
//     });
//   }

//   Container _filialAtiva(Filial filial) {
//     return Container(
//       padding: const EdgeInsets.only(left: 10, top: 10),
//       child: Row(
//         children: <Widget>[
//           const Text('Filial Ativa?'),
//           SizedBox(width: 20),
//           CupertinoSwitch(
//             trackColor: Colors.red,
//             value: filial.ativo,
//             onChanged: (v) => setState(() => filial.ativo = v),
//           ),
//         ],
//       ),
//     );
//   }

//   Container _filialVisivel(Filial filial) {
//     return Container(
//       padding: const EdgeInsets.only(left: 10, top: 10),
//       child: Row(
//         children: <Widget>[
//           const Text('Visível no Mobile?'),
//           SizedBox(width: 20),
//           CupertinoSwitch(
//             trackColor: Colors.red,
//             value: filial.visivel,
//             onChanged: (v) => setState(() => filial.visivel = v),
//           ),
//         ],
//       ),
//     );
//   }
// }
