


////// CODIGO TOTALMENTE FUNCIONAL...RETORNA FILE E SALVA EM GALERIA



// import 'dart:io';
// import 'dart:ui' as ui;
// // import 'package:MeuPedido/app/utils/storage.dart';
// import 'package:flutter/material.dart';
// import 'package:crop/crop.dart';

// // import 'package:url_launcher/url_launcher.dart';
// // import 'package:image_gallery_saver/image_gallery_saver.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'centered_slider_track_shape.dart';

// class AgCropPage extends StatefulWidget {
//   final File fileOriginal;

//   const AgCropPage({Key key, this.fileOriginal}) : super(key: key);
//   @override
//   _AgCropPageState createState() => _AgCropPageState();
// }

// class _AgCropPageState extends State<AgCropPage> {
//   final controller = CropController(aspectRatio: 1000 / 667.0);
//   double _rotation = 0;
//   Image imgAtual ; //= Image.file( wi  fileOriginal, fit: BoxFit.cover,);
//   //   'assets/food7.jpeg',
//   //   fit: BoxFit.cover,
//   // );

//   // void _cropImage() async {
//   //   final pixelRatio = MediaQuery.of(context).devicePixelRatio;
//   //   final cropped = await controller.crop(pixelRatio: pixelRatio);

//   //   Navigator.of(context).push(
//   //     MaterialPageRoute(
//   //       builder: (context) => Scaffold(
//   //         appBar: AppBar(
//   //           title: Text('Crop Result'),
//   //           centerTitle: true,
//   //           actions: [
//   //             Builder(
//   //               builder: (context) => IconButton(
//   //                 icon: Icon(Icons.save),
//   //                 onPressed: () async {
//   //                   final status = await Permission.storage.request();
//   //                   if (status == PermissionStatus.granted) {
//   //                     await _saveScreenShot(cropped);
//   //                     Scaffold.of(context).showSnackBar(
//   //                       SnackBar(
//   //                         content: Text('Saved to gallery.'),
//   //                       ),
//   //                     );
//   //                   }
//   //                 },
//   //               ),
//   //             ),
//   //             IconButton(
//   //               icon: Icon(Icons.file_upload),
//   //               onPressed: () async {
//   //                 var file = await _retornaFile(cropped);

//   //                 uploadStorage(inicioNome: 'TesteCrop', file: file)
//   //                     .then((url) {
//   //                   return print(url);
//   //                 });
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //         body: Center(
//   //           child: RawImage(
//   //             image: cropped,
//   //           ),
//   //         ),
//   //       ),
//   //       fullscreenDialog: true,
//   //     ),
//   //   );
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     Image imgAtual = Image.file( widget.fileOriginal, fit: BoxFit.cover,);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cortar Imagem'),
//         centerTitle: true,
//         // actions: <Widget>[
//         //   IconButton(
//         //     onPressed: _cropImage,
//         //     tooltip: 'Crop',
//         //     icon: Icon(Icons.crop),
//         //   )
//         // ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Container(
//             height: 50,
//             color: Colors.white,
//             child: _menuSuperior(),
//           ),
//           Expanded(
//             child: Container(
//               color: Colors.black,
//               padding: EdgeInsets.all(8),
//               child: Crop(
//                 controller: controller,
//                 child: imgAtual, //It's very important to set fit: BoxFit.cover.
//                 helper: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.white, width: 2),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           _opcaoInferior(theme),
//         ],
//       ),
//     );
//   }

//   Widget _menuSuperior() {
//     return FlatButton.icon(
//       //color: Colors.blueGrey,
//       icon: Icon(Icons.photo_library),
//       label: Text('Confirmar Imagem'),
//       onPressed: () async {
//         final pixelRatio = MediaQuery.of(context).devicePixelRatio;
//         final cropped = await controller.crop(pixelRatio: pixelRatio);
//         var file = await _retornaFile(cropped);
//         //////
//         Navigator.pop<File>(context, file);
//         /////
//       },
//     );

//     // return Row(
//     //   children: [
//     //     FlatButton.icon(
//     //       icon: Icon(Icons.photo_library),
//     //       label: Text('galeria'),
//     //       onPressed: () {
//     //         ImagePicker.pickImage(source: ImageSource.gallery)
//     //             .then((imgFile) async {
//     //           if (imgFile == null) return;

//     //           imgAtual = Image.file(imgFile, fit: BoxFit.cover);
//     //           setState(() {});

//     //           //
//     //         });
//     //       },
//     //     ),
//     //     FlatButton.icon(
//     //       icon: Icon(Icons.camera),
//     //       label: Text('camera'),
//     //       onPressed: () {
//     //         ImagePicker.pickImage(source: ImageSource.camera)
//     //             .then((imgFile) async {
//     //           if (imgFile == null) return;

//     //           imgAtual = Image.file(imgFile, fit: BoxFit.cover);
//     //           setState(() {});

//     //           //
//     //         });
//     //       },
//     //     ),
//     //   ],
//     // );
//   }

//   Row _opcaoInferior(ThemeData theme) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: Icon(Icons.undo),
//           tooltip: 'Undo',
//           onPressed: () {
//             controller.rotation = 0;
//             controller.scale = 1;
//             controller.offset = Offset.zero;
//             setState(() {
//               _rotation = 0;
//             });
//           },
//         ),
//         Expanded(
//           child: SliderTheme(
//             data: theme.sliderTheme.copyWith(
//               trackShape: CenteredRectangularSliderTrackShape(),
//             ),
//             child: Slider(
//               divisions: 361,
//               value: _rotation,
//               min: -180,
//               max: 180,
//               label: '$_rotation°',
//               onChanged: (n) {
//                 setState(() {
//                   _rotation = n.roundToDouble();
//                   controller.rotation = _rotation;
//                 });
//               },
//             ),
//           ),
//         ),
//         _menuProporcao(),
//       ],
//     );
//   }

//   PopupMenuButton<double> _menuProporcao() {
//     return PopupMenuButton<double>(
//       icon: Icon(Icons.aspect_ratio),
//       itemBuilder: (context) => [
//         PopupMenuItem(
//           child: Text("Original"),
//           value: 1000 / 667.0,
//         ),
//         PopupMenuDivider(),
//         PopupMenuItem(
//           child: Text("16:9"),
//           value: 16.0 / 9.0,
//         ),
//         PopupMenuItem(
//           child: Text("4:3"),
//           value: 4.0 / 3.0,
//         ),
//         PopupMenuItem(
//           child: Text("1:1"),
//           value: 1,
//         ),
//         PopupMenuItem(
//           child: Text("3:4"),
//           value: 3.0 / 4.0,
//         ),
//         PopupMenuItem(
//           child: Text("9:16"),
//           value: 9.0 / 16.0,
//         ),
//       ],
//       tooltip: 'Aspect Ratio',
//       onSelected: (x) {
//         controller.aspectRatio = x;
//         setState(() {});
//       },
//     );
//   }
// }

// // Future<dynamic> _saveScreenShot(ui.Image img) async {
// //   var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
// //   var buffer = byteData.buffer.asUint8List();
// //   final result = await ImageGallerySaver.saveImage(buffer);
// //   print(result);

// //   return result;
// // }

// Future<File> _retornaFile(ui.Image img) async {
//   var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
//   var buffer = byteData.buffer
//       .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

//   final file = File(
//       '${(await getTemporaryDirectory()).path}/${DateTime.now().millisecondsSinceEpoch.toString()}.png');
//   await file.writeAsBytes(buffer);

//   return file;
// }
