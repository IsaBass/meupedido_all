// import 'package:MeuPedido/app/utils/crop_foto/agcrop.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'ag_image_cropper.dart';

Future<void> showOptionsFotoCadastro(
    {@required BuildContext ctx,
    @required Function onSimExcluir,
    @required String inicioArquivo,
    @required Function onNovoArquivo(String novaUrl)}) async {
  await showModalBottomSheet(
    context: ctx,
    builder: (_) {
      return BottomSheet(
          //animationController: AnimationController(vsync: null),
          onClosing: () {},
          builder: (_) {
            return Container(
              color: Color(0xFF737373),
              child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[800],
                        blurRadius: 10,
                        spreadRadius: 3),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // (
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                ),
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child:
                          Container(height: 3, color: Colors.grey, width: 60),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Alteração de foto:',
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                    Divider(height: 10),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: _botaoDaGaleria(
                            context: ctx,
                            inicioArquivo: inicioArquivo,
                            onNovoArquivo: onNovoArquivo,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _botaDaCamera(
                            context: ctx,
                            inicioArquivo: inicioArquivo,
                            onNovoArquivo: onNovoArquivo,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: _botaoLimparFoto(ctx, onSimExcluir),
                        ),
                        //_botaoLimparFoto(context),
                      ],
                    ),
                  ],
                ),
              ),
            );
          });
    },
  );
}

Future<bool> _showPerguntaLimpar(
    BuildContext context, Function onSimExcluir) async {
  return await Alert(
    context: context,
    type: AlertType.warning,
    title: 'Eliminar Foto',
    desc: "Confirma eliminação desta foto?",
    buttons: [
      DialogButton(
        width: 130,
        child: Text(
          "EXCLUIR",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        onPressed: () {
          onSimExcluir();
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

Widget _botaoOpcaoInferior(
    {BuildContext context, IconData icon, String label, Function onPressed}) {
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
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(icon, size: 32, color: Colors.black),
            SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
            ),
          ],
        ),
        onPressed: onPressed,
      ),
    ),
  );
}

Widget _botaoLimparFoto(BuildContext context, Function onSim) {
  return _botaoOpcaoInferior(
    context: context,
    icon: Icons.delete_forever,
    label: 'Limpar',
    onPressed: () => _showPerguntaLimpar(context, onSim)
        .then((value) => Navigator.pop(context))
        .catchError((onError) => Navigator.pop(context)),
  );
}

Widget _botaDaCamera(
    {BuildContext context,
    String inicioArquivo,
    Function onNovoArquivo(String novaUrl)}) {
  return _botaoOpcaoInferior(
    icon: Icons.photo_camera,
    label: 'Câmera',
    onPressed: () async {
      await _chamaPickImg(
        context: context,
        source: ImageSource.camera,
        inicioArquivo: inicioArquivo,
        onNovoArquivo: onNovoArquivo,
      );
      Navigator.pop(context);
    },
  );
}

Widget _botaoDaGaleria(
    {BuildContext context,
    String inicioArquivo,
    Function onNovoArquivo(String novaUrl)}) {
  return _botaoOpcaoInferior(
    icon: Icons.photo_library,
    label: 'Galeria',
    onPressed: () async {
      await _chamaPickImg(
        context: context,
        source: ImageSource.gallery,
        inicioArquivo: inicioArquivo,
        onNovoArquivo: onNovoArquivo,
      );
      Navigator.pop(context);
    },
  );
}

Future<String> _chamaPickImg(
    {BuildContext context,
    String inicioArquivo,
    ImageSource source,
    Function onNovoArquivo(String novaUrl)}) async {
  ///
  var imgFile = await ImagePicker().getImage(source: source);

  if (imgFile == null) return null;
  //
  // // CROP IMAGE   .. COD TOTALMENTE FUNCIONAL TAMBEM
  // var newFile = await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (context) => AgCropPage(fileOriginal: imgFile)));
  // //
  var newFile = await agImageCropper(imgFile.path);
  if (newFile == null) return null;
  //
  var url = await uploadStorage(inicioNome: inicioArquivo, file: newFile);
  if (url?.isEmpty ?? true) return null;
  //
  onNovoArquivo(url);
  //
  return url;

  ///
}

/*
Future<void> retrieveLostData() async {
  final LostDataResponse response =
      await ImagePicker.retrieveLostData();
  if (response == null) {
    return;
  }
  if (response.file != null) {
    setState(() {
      if (response.type == RetrieveType.video) {
        _handleVideo(response.file);
      } else {
        _handleImage(response.file);
      }
    });
  } else {
    _handleError(response.exception);
  }
}
*/
