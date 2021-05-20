import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/modules/home/tabs/perfil/perfil_page.dart';
import 'package:MeuPedido/app/widgets/nao_logado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PerfilTab extends StatelessWidget {
  final AppController _appController = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return _appController.estaLogado ? PerfilPage() : NaoLogado();
    });
  }
}
