import 'package:flutter/material.dart';
//
import 'package:meupedido_core/meupedido_core.dart';

import 'tabs/tab.cadastro.dart';
import 'tabs/tab.empresas.dart';
import 'tabs/tab.outros.dart';

class ConfigsPage extends StatefulWidget {
  final String title;
  const ConfigsPage({Key key, this.title = "Configs"}) : super(key: key);

  @override
  _ConfigsPageState createState() => _ConfigsPageState();
}

class _ConfigsPageState extends State<ConfigsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        //drawer: drawerMain(),
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_outline)),
              Tab(icon: Icon(Icons.business)),
              Tab(icon: Icon(Icons.build)),
            ],
          ),
          title: Row(
            children: <Widget>[
              Icon(Icons.settings),
              SizedBox(width: 12),
              Text('Configurações'),
            ],
          ),
        ),
        body: Align(
          child: ConstrainedBox(
            constraints: MyConst.boxConstraints,
            child: TabBarView(
              children: [
                TabConfigCadastro(),
                TabConfigEmpresas(),
                TabConfigOutros(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
