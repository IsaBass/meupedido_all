import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BtnFavorito extends StatefulWidget {
  final String codigoProduto;

  const BtnFavorito({Key key, this.codigoProduto}) : super(key: key);
  @override
  _BtnFavoritoState createState() => _BtnFavoritoState();
}

class _BtnFavoritoState extends State<BtnFavorito> {
  //
  final AppController _appController = Modular.get();
  //

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        _appController.changeFavorito(widget.codigoProduto);
      },
      fillColor: Colors.white,
      shape: CircleBorder(),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Observer(builder: (_) {
          return Icon(
            _appController.isFavorito(widget.codigoProduto)
                ? Icons.favorite
                : Icons.favorite_border,
            color: Colors.red,
            size: 17,
          );
        }),
      ),
    );
  }
}
