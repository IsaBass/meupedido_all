import 'package:MeuPedido/app/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MeusPedidosRepository extends Disposable {
  final AppController _appController;

  MeusPedidosRepository(this._appController); //= Modular.get();

  Future<List<Map>> getPedidos() async {
    var docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(_appController.userAtual.uid)
        .collection('pedidos${_appController.cnpjAtivo.docId}')
        .orderBy('dataHora', descending: true)
        .get();
    //
    List<Map> lAux = [];

    lAux.addAll(docs.docs.map((e) => e.data()).toList());

    return lAux;
  }

  Stream<QuerySnapshot> streamPedidos() => FirebaseFirestore.instance
      .collection("users")
      .doc(_appController.userAtual.uid)
      .collection('pedidos${_appController.cnpjAtivo.docId}')
      .orderBy('dataHora', descending: true)
      .limit(10)
      .snapshots();

  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPedidoUnico(
          String idPedido) =>
      FirebaseFirestore.instance
          .collection("CNPJS")
          .doc(_appController.cnpjAtivo.docId)
          .collection('pedidos')
          .doc(idPedido)
          .snapshots();

  @override
  void dispose() {}
}
