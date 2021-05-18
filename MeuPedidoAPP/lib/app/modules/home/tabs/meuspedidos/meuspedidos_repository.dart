import 'package:MeuPedido/app/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeusPedidosRepository extends Disposable {
  final AppController _appController = Modular.get();

  Future<List<Map>> getPedidos() async {
    var docs = await _appController.userAtualDocRef
        .collection('pedidos${_appController.cnpjAtivoDocRef.id}')
        .orderBy('dataHora', descending: true)
        .get();
    //
    List<Map> lAux = [];

    lAux.addAll(docs.docs.map((e) => e.data()).toList());

    return lAux;
  }

  Stream<QuerySnapshot> streamPedidos() => _appController.userAtualDocRef
      .collection('pedidos${_appController.cnpjAtivoDocRef.id}')
      .orderBy('dataHora', descending: true)
      .limit(10)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPedidoUnico(
          String idPedido) =>
      _appController.cnpjAtivoDocRef
          .collection('pedidos')
          .doc(idPedido)
          .snapshots();

  @override
  void dispose() {}
}
