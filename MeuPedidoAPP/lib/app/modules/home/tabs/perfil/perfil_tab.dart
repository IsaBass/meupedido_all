import 'package:MeuPedido/app/app_module.dart';

import 'package:MeuPedido/app/modules/home/tabs/perfil/perfil_page.dart';
import 'package:MeuPedido/app/widgets/nao_logado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

class PerfilTab extends StatelessWidget {
  final AuthController _authController = Modular.get<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _authController.estaLogado ? PerfilPage() : NaoLogado();
    });
  }
}
