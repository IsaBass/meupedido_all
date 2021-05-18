import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NaoLogado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _widgNaoEstaoLogado(context);
  }

  Widget _widgNaoEstaoLogado(BuildContext ctx) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Você não está logado!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Icon(
              FontAwesomeIcons.userSecret,
              size: 100,
              color: Theme.of(ctx).primaryColor,
            ),
            SizedBox(height: 15),
            _botaoLogar(ctx),
          ],
        ),
      );

  Widget _botaoLogar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      child: ElevatedButton.icon(
        // color: Theme.of(context).primaryColor,
        icon: Icon(
          FontAwesomeIcons.userShield,
          color: Theme.of(context).primaryTextTheme.bodyText1.color,
        ),
        label: Text(
          '    Login de Usuário',
          style: TextStyle(
            color: Theme.of(context).primaryTextTheme.bodyText1.color,
          ),
        ),
        onPressed: () => Modular.to.pushNamed('login'),
      ),
    );
  }
}
