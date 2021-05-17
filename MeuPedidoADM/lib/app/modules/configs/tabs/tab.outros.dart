import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class TabConfigOutros extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        _cardVerEmpresas(),
      ],
    );
  }

  Widget _cardVerEmpresas() {
    return Card(
      child: ListTile(
        leading: Icon(Icons.business),
        title: Text('Empresas'),
        subtitle: Text('Acesso ao cadastro geral de empresas'),
        trailing: IconButton(
          icon: Icon(Icons.arrow_forward_ios),
          onPressed: () => Modular.to.pushNamed('/configs/empresas'),
        ),
      ),
    );
  }
}
