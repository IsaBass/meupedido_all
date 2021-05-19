import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardLogout extends StatelessWidget {
  final double elevCards;
  final RoundedRectangleBorder shapeCards;
  //
  CardLogout({Key key, this.elevCards = 2.0, this.shapeCards})
      : super(key: key);
  //
  final AppController _appController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevCards,
      shape: shapeCards, //    ,
      child: Container(
        constraints: BoxConstraints(minHeight: 50),
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: ListTile(
          title: Text('Sair'),
          leading: Icon(FontAwesomeIcons.userAltSlash,
              color: Theme.of(context).accentColor),
          trailing: IconButton(
            icon: Icon(FontAwesomeIcons.doorOpen),
            onPressed: () {
              _appController.signOut();
            },
          ),
        ),
      ),
    );
  }
}
