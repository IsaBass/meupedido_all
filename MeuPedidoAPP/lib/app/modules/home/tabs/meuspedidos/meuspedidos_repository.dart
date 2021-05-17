import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeusPedidosRepository extends Disposable {
  final AppController _appController = AppModule.to.get();

  Future<List<Map>> getPedidos() async {
    var docs = await _appController.userAtualDocRef
        .collection('pedidos${_appController.cnpjAtivoDocRef.documentID}')
        .orderBy('dataHora', descending: true)
        .getDocuments();
    //
    List<Map> lAux = [];
    for (var doc in docs.documents) {
      lAux.add(doc.data);
    }

    return lAux;
  }

  Stream<QuerySnapshot> streamPedidos() => _appController.userAtualDocRef
      .collection('pedidos${_appController.cnpjAtivoDocRef.documentID}')
      .orderBy('dataHora', descending: true)
      .limit(10)
      .snapshots();

  Stream<DocumentSnapshot> streamPedidoUnico(String idPedido) =>
      _appController.cnpjAtivoDocRef
          .collection('pedidos')
          .document(idPedido)
          .snapshots();

  @override
  void dispose() {}
}
