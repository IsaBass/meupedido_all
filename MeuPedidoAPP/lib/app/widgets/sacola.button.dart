import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meupedido_core/meupedido_core.dart';

class SacolaButton extends StatefulWidget {
  @override
  _SacolaButtonState createState() => _SacolaButtonState();
}

class _SacolaButtonState extends State<SacolaButton> {
  final CartController _cartController = AppModule.to.get();
  @override
  Widget build(BuildContext context) {
    return IconButton(
            icon: Observer(builder: (_) {
              return IconBadge(
                icon: FontAwesomeIcons.shoppingBasket,
                size: 24.0,
                numero: _cartController.cartAtual?.qtdItens ?? 0,
                // numero: _appController.   cartAtual?.qtdItens ?? 0,
              );
            }),
            onPressed: () => Modular.to.pushNamed('/cart'),
          );
  }
}