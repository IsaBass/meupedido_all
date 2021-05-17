import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'empresas_controller.dart';
import 'empresas_module.dart';

class EmpresasPage extends StatefulWidget {
  final String title;
  const EmpresasPage({Key key, this.title = "Cadastro Empresas"})
      : super(key: key);

  @override
  _EmpresasPageState createState() => _EmpresasPageState();
}

class _EmpresasPageState extends State<EmpresasPage> {
  EmpresasController controller = EmpresasModule.to.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ConstrainedBox(
              constraints: MyConst.boxConstraints,
              child: RefreshIndicator(
                onRefresh: controller.carregaEmpresas,
                child: Observer(builder: (_) {
                  if (controller.listaEmp == null)
                    return Center(child: LinearProgressIndicator());

                  var list = [];
                  if (controller.listaEmp != null) list = controller.listaEmp;

                  return ListView(
                    children: list.map((e) => _listTile(e)).toList(),
                  );

                  // return ListView.builder(
                  //   itemCount: controller.listaEmp.value.length,
                  //   itemBuilder: (context, idx) {
                  //     return _listTile(controller.listaEmp.value[idx]);
                  //   },
                  // );
                }),
              ))),
      floatingActionButton: FloatingActionButton.extended(
        isExtended: true,
        icon: Icon(Icons.add),
        label: Text('Nova'),
        onPressed: () {
          CnpjModel e = CnpjModel(
            ativo: true,
            cChave: '',
            descricao: '',
            tipo: 'CENTRAL',
            //dadosFiliais: [],
          );
          Modular.to.pushNamed('/configs/empresas/edit',
              arguments: {"emp": e, "func": funcSalvarNovo});
          //Modular.to.pushNamed('/configs/empresas/add' );
        },
      ),
    );
  }

  Widget _listTile(CnpjModel e) {
    return ListTile(
      leading: e.tipo == 'CENTRAL'
          ? Icon(Icons.business)
          : Icon(Icons.store_mall_directory),
      title: Text(e.descricao),
      subtitle: Text('CNPJ: ${e.docId}'),
      trailing: IconButton(
        icon: Icon(Icons.arrow_forward_ios),
        onPressed: () {
          Modular.to.pushNamed('/configs/empresas/edit',
              arguments: {"emp": e, "func": funcSalvarEdit});
        },
      ),
    );
  }

  funcSalvarEdit(CnpjModel emp) async {
    await controller.saveEmpresa(emp);
  }

  funcSalvarNovo(CnpjModel emp) async {
    await controller.saveNovaEmpresa(emp);
  }
}
