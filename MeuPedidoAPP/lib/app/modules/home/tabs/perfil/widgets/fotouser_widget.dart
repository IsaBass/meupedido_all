import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

class FotoUserWidget extends StatefulWidget {
  @override
  _FotoUserWidgetState createState() => _FotoUserWidgetState();
}

class _FotoUserWidgetState extends State<FotoUserWidget> {
  final AppController _appController = Modular.get();
  final AuthController _authController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
          width: 120.0,
          height: 120.0,
          child: ClipOval(
            // clipper: ,
            child: agImageProvider(
              imgTipo: 'EXT',
              imgUrl: _appController.userAtual.urlImg,
              fit: BoxFit.cover,
            ),
          )),
      onLongPress: () async {
        await showOptionsFotoCadastro(
          ctx: context,
          inicioArquivo: _appController.userAtual.uid,
          onSimExcluir: () {
            setState(() {
              return _appController.userAtual.urlImg = '';
            });
            _authController.saveUserData(
              _appController.userAtual,
              _appController.cnpjAtivo.docId,
              alterarLoading: true,
            );
          },
          onNovoArquivo: (novaUrl) {
            if (novaUrl == null || novaUrl.isEmpty) return;
            //
            setState(() {
              _appController.userAtual.urlImg = novaUrl;
            });
            _authController.saveUserData(
              _appController.userAtual,
              _appController.cnpjAtivo.docId,
              alterarLoading: true,
            );
            return;
          },
        );
      },
    );
  }
}
