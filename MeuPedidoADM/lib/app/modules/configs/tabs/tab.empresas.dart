import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:meupedidoADM/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'widgets/empresa.wid.dart';

class TabConfigEmpresas extends StatelessWidget {
  // final ConfigsController _configController =
  //     ConfigsModule.to.get<ConfigsController>();
  final AuthController _controller = AppModule.to.get();

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: RefreshIndicator(
          onRefresh: () async {
            await _controller.recarregaUserEmpresas();
          },
          child: Observer(
            builder: (_) {
              if (_controller.userAtual.empresas == null ||
                  _controller.userAtual.empresas.length == 0)
                return Center(
                    child: Container(
                        child: Text('Não cadastrado em nenhuma empresa')));

              return ListView.builder(
                itemCount: _controller.userAtual.empresas.length,
                itemBuilder: (context, index) => listTileEmpresa(
                    _controller.userAtual.empresas[index], context),
                // children: _controller.userAtual.empresas
                //     .map((e) => listTileEmpresa(e, context))
                //     .toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //backgroundColor: Colors.green,
        child: Icon(Icons.add, size: 40),
        onPressed: () => showCadastraEmpresa(context),
      ),
    );
  }

  Widget listTileEmpresa(UserEmpresa e, BuildContext ctx) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 7,
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.business,
            color: e.cnpjM.docId == _controller.userAtual.cnpjPadrao
                ? Colors.green
                : Colors.grey,
          ),
          trailing: IconButton(
            icon: Icon(Icons.menu),

            //color: Colors.blue,
            onPressed: () =>
                showOptionsEmpresa(e, ctx, _controller.userAtual.perfil),
          ),
          title: _descricaoEmpresa(e),
          subtitle:  _statusInferior(e),
          // Text('Pendente de Aprovação', overflow: TextOverflow.ellipsis,
          //               style: TextStyle(color: Colors.black, fontSize: 18)),
          onLongPress: () =>
              showOptionsEmpresa(e, ctx, _controller.userAtual.perfil),
        ),
      ),
    );
  }

  Widget _descricaoEmpresa(UserEmpresa e) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(e.cnpjM.descricao,
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              )),
          Text(e.cnpjM.docId),
          //SizedBox(height: 7)
        ],
      );

  Widget _statusInferior(UserEmpresa e) => Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisSize: MainAxisSize.min,
          //textDirection: TextDirection.rtl,
          children: <Widget>[
            e.status == 'BLOCK'
                ? Icon(Icons.block, color: Colors.red)
                : Icon(Icons.verified_user,
                    color: e.status == 'OK' ? Colors.green : Colors.grey,
                    size: 22),
            SizedBox(width: 7),
            e.status == 'BLOCK'
                ? Text('USUÁRIO BLOQUEADO')
                : e.status == 'OK'
                    ? Text('Verificado')
                    : Text('Pendente de Aprovação',overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black, fontSize: 13)),
          ],
        ),
      );
}
