// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meupedidoADM/app/app_module.dart';
// import 'package:meupedido_core/meupedido_core.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';

// Future<bool> showPerguntaLimpar(BuildContext context) async {
//   //ConfigsController _controller = ConfigsModule.to.get<ConfigsController>();
//   AuthController _authController = AppModule.to.get<AuthController>();

//   return await Alert(
//     context: context,
//     type: AlertType.warning,
//     title: 'Eliminar Foto',
//     desc: "Confirma eliminação desta foto?",
//     buttons: [
//       DialogButton(
//         width: 130,
//         child: Text(
//           "SIM, EXCLUIR",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () {
//           _authController.userAtual.urlImg = (null);
//           Navigator.pop(context);
//         },
//       ),
//       DialogButton(
//         child: Text(
//           "VOLTAR",
//           style: TextStyle(color: Colors.white, fontSize: 20),
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//         width: 120,
//       ),
//     ],
//   ).show();
// }

// void showOptionsFotoCadastro(BuildContext context) {
//   AuthController _authController = AppModule.to.get<AuthController>();
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return BottomSheet(
//           //animationController: AnimationController(vsync: null),
//           onClosing: () {},
//           builder: (context) {
//             return Container(
//               color: Color(0xFF737373),
//               child: Container(
//                 margin: EdgeInsets.all(15),
//                 // color: Colors.white,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey[800],
//                       blurRadius: 10,
//                       spreadRadius: 3,
//                     ),
//                   ],
//                   borderRadius: BorderRadius.all(Radius.circular(10)),
//                   // (
//                   //   topLeft: Radius.circular(10),
//                   //   topRight: Radius.circular(10),
//                   // ),
//                 ),
//                 padding: EdgeInsets.all(10.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     GestureDetector(
//                       onTap: () => Navigator.pop(context),
//                       child:
//                           Container(height: 3, color: Colors.grey, width: 60),
//                     ),
//                     SizedBox(height: 5),
//                     Text(
//                       'Alteração da foto do usuário',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     Divider(height: 10),
//                     Row(
//                       //mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Expanded(
//                           flex: 1,
//                           child: _botaoDaGaleria(_authController, context),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: _botaDaCamera(_authController, context),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: _botaoLimparFoto(context),
//                         ),
//                         //_botaoLimparFoto(context),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           });
//     },
//   );
// }

// Widget _botaoOpcaoInferior({IconData icon, String label, Function onPressed}) {
//   return Container(
//     height: 80,
//     margin: EdgeInsets.all(5),
//     child: Container(
//       //decoration: Boxdeco,
//       child: RaisedButton(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//              Icon(icon, size: 32),
//             SizedBox(height: 6),
//             Text(
//               label,
//               style: TextStyle(color: Colors.red, fontSize: 14.0),
//             ),
//           ],
//         ),
//         onPressed: onPressed,
//       ),
//     ),
//   );
// }

// Widget _botaoLimparFoto(BuildContext context) {
//   return _botaoOpcaoInferior(
//     icon: Icons.delete_forever,
//     label: 'Limpar',
//     onPressed: () => showPerguntaLimpar(context)
//         .then((value) => Navigator.pop(context))
//         .catchError((onError) => Navigator.pop(context)),
//   );
// }

// Widget _botaDaCamera(AuthController _authController, BuildContext context) {
//   return _botaoOpcaoInferior(
//     icon: Icons.photo_camera,
//     label: 'da Câmera',
//     onPressed: () {
//       ImagePicker.pickImage(source: ImageSource.camera).then((imgFile) async {
//         if (imgFile == null) return;

        
//             uploadStorage(
//                 inicioNome: _authController.userAtual.firebasebUser.uid,
//                 file: imgFile)
//             .then((url) => _authController.userAtual.urlImg = (url));
//       });
//       Navigator.pop(context);
//     },
//   );
// }

// Widget _botaoDaGaleria(AuthController _authController, BuildContext context) {
//   return _botaoOpcaoInferior(
//     icon: Icons.photo_library,
//     label: 'da Galeria',
//     onPressed: () {
//       //launch("tel:${contacts[index].phone}");
//       ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) async {
//         if (imgFile == null) return;

//         uploadStorage(
//                 inicioNome: _authController.userAtual.firebasebUser.uid,
//                 file: imgFile)
//             .then((url) => _authController.userAtual.urlImg = (url));
//       });
//       Navigator.pop(context);
//     },
//   );
// }
