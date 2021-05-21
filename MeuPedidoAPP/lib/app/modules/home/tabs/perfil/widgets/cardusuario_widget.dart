import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'fotouser_widget.dart';

class CardUsuarioWidget extends StatelessWidget {
  final double elevCards;
  final RoundedRectangleBorder shapeCards;

  CardUsuarioWidget({Key key, this.elevCards, this.shapeCards})
      : super(key: key);

  final AppController _appController = Modular.get();

  @override
  Widget build(BuildContext context) {
    //
    return Observer(builder: (_) {
      //
      var user = _appController.userAtual;
      //
      return Card(
        elevation: elevCards,
        shape: shapeCards, //    ,
        child: Container(
          constraints: BoxConstraints(minHeight: 150),
          // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(minHeight: 150),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FotoUserWidget(),
                    //SizedBox(width: 10),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(user.nome,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                          Text(user.email,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                          Text(user.telefone,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //Positioned(top: 5, child: FaIcon(FontAwesomeIcons.user)),
              Positioned(
                  right: 5,
                  bottom: 0,
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.edit, color: Colors.grey),
                    onPressed: () async {
                      if ((await Modular.to.pushNamed('editusuario/')) ==
                          true) {
                        mySnackBar(context,
                            texto: "Cadastro salvo com sucesso.",
                            color: Colors.indigo[900],
                            miliseconds: 1500);
                      }
                    },
                  )),
            ],
          ),
        ),
      );
    });
  }
}
