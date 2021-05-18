// import 'package:MeuPedido/app/categs/categs_controller.dart';
// import 'package:MeuPedido/app/widgets/produtos/painel.adicionais.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:meupedido_core/meupedido_core.dart';

// class FavoritosTab extends StatefulWidget {
//   @override
//   _FavoritosTabState createState() => _FavoritosTabState();
// }

// class _FavoritosTabState extends State<FavoritosTab> {
//   final CategsController _categsController = Modular.get<CategsController>();
//   int codCateg = 0;

//   @override
//   Widget build(BuildContext context) {
//     print('reconstruiu FavoritosTAb');
//     return _testeCategAdicionais();
//   }

//   Column _testeCategAdicionais() {
//     return Column(
//       children: <Widget>[
//         Text(' Favoritos TAB '),
//         FlatButton(
//           child: Text('Criar Categoria'),
//           onPressed: () {
//             codCateg++;

//             _categsController.categs.add(CategoriaModel(
//                 codCateg: codCateg, descricao: 'CategCriada $codCateg'));
//           },
//         ),
//         Expanded(
//           child: ListView(
//             children: [
//               Observer(builder: (_) {
//                 return Column(
//                   children: _categsController.categs
//                       .map((categ) => Card(
//                             elevation: 10,
//                             child: Column(
//                               children: [
//                                 Text(categ.descricao),
//                                 _botoesDaCateg(categ),
//                                 PainelAdicional(
//                                     grupoAdicionais: categ.grupoAdicionais),
//                               ],
//                             ),
//                           ))
//                       .toList(),
//                 );
//               }),
//               SizedBox(height: 30), // << para botao flutuante na cobrir a lista
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Row _botoesDaCateg(CategoriaModel categ) {
//     //  print('reconstruiu botoesdaCateg');
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         RaisedButton.icon(
//           onPressed: () {
//             var grp = AdicionalGrpModel(
//               codGrupo: 1,
//               descricao: 'Grupo Apenas 1',
//               // tipoEscolha: 'U',
//               ordem: 1,
//               valorAtual: '',
//               adics: [],
//               maxQtd: 1,
//               minQtd: 1,
//             );
//             var adic = AdicionalModel(
//                 codigo: 1, descricao: 'opcao 1', valor: '01', preco: 0.00);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 2, descricao: 'opcao 2', valor: '02', preco: 2.50);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 3, descricao: 'opcao 3', valor: '03', preco: 7.00);
//             grp.adics.add(adic);

//             categ.grupoAdicionais.add(grp);
//           },
//           icon: Icon(Icons.add_box),
//           label: Text('add U'),
//         ),
//         RaisedButton.icon(
//           onPressed: () {
//             var grp = AdicionalGrpModel(
//               codGrupo: 1,
//               descricao: 'Grupo 3 obrigatorio',
//               // tipoEscolha: 'C',
//               ordem: 1,
//               valorAtual: '',
//               minQtd: 3,
//               maxQtd: 3,
//             );
//             var adic = AdicionalModel(
//                 codigo: 1, descricao: 'marca 1', valor: '01', preco: 1.00);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 2, descricao: 'marca 2', valor: '02', preco: 12.00);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 3, descricao: 'marca 3', valor: '03', preco: 3.00);
//             grp.adics.add(adic);

//             categ.grupoAdicionais.add(grp);
//           },
//           icon: Icon(Icons.add_box),
//           label: Text('add M5'),
//         ),
//         RaisedButton.icon(
//           onPressed: () {
//             var grp = AdicionalGrpModel(
//                 codGrupo: 1,
//                 descricao: 'Grupo de 0 a 5',
//                 // tipoEscolha: 'Q',
//                 ordem: 1,
//                 valorAtual: '',
//                 minQtd: 0,
//                 maxQtd: 5);
//             var adic = AdicionalModel(
//                 codigo: 1, descricao: 'marca 1', valor: '01', preco: 1.00);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 2, descricao: 'marca 2', valor: '02', preco: 12.00);
//             grp.adics.add(adic);
//             adic = AdicionalModel(
//                 codigo: 3, descricao: 'marca 3', valor: '03', preco: 3.00);
//             grp.adics.add(adic);

//             categ.grupoAdicionais.add(grp);
//           },
//           icon: Icon(Icons.add_box),
//           label: Text('add p Qtd'),
//         ),
//       ],
//     );
//   }
// }
