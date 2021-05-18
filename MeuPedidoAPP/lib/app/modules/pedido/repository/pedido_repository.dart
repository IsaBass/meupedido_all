import 'package:MeuPedido/app/app_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'pedido_interf_repository.dart';

class PedidoRepository extends Disposable implements IPedidoRepository {
  final AppController _appController;
  final AuthController _authController;
  final FCMFirebase _fcmFirebase = Modular.get<FCMFirebase>();

  PedidoRepository(this._appController, this._authController);

  Stream<Map<String, dynamic>> getPedido(String idPedido) {
    /////
    return _appController.cnpjAtivoDocRef
        .collection('pedidos')
        .doc(idPedido)
        .snapshots()
        .map((doc) => doc.data()..['docId'] = doc.id);
    /////
  }

  void cancelePedido(String idPedido, String motivo, String statusAtual) {
    /////
    _appController.cnpjAtivoDocRef.collection('pedidos').doc(idPedido).set(
      {"status": "CANCEL", "motivoCancelamento": motivo},
      SetOptions(merge: true),
    );
    //

    _registraHistoricoPedido(
        idPedido: idPedido,
        campoAlterado: 'status',
        valorAnterior: statusAtual,
        valorNovo: 'CANCEL');
    //
    _fcmFirebase.fcmAdministradores(
      cnpj: _appController.cnpjAtivoDocId,
      titulo: "Pedido Cancelado",
      body: "O pedido #$idPedido foi cancelado",
    );
    /////
  }

  void cancelePendentePedido(
      String idPedido, String motivo, String statusAtual) {
    /////
    _appController.cnpjAtivoDocRef.collection('pedidos').doc(idPedido).set(
      {"status": "CANCEL.P", "motivoCancelamento": motivo},
      SetOptions(merge: true),
    );
    //

    _registraHistoricoPedido(
        idPedido: idPedido,
        campoAlterado: 'status',
        valorAnterior: statusAtual,
        valorNovo: 'CANCEL.P');
    //
    _fcmFirebase.fcmAdministradores(
      cnpj: _appController.cnpjAtivoDocId,
      titulo: "Solicitação de Cancelamento",
      body: "Solicitação de Cancelamento para o pedido #$idPedido",
    );
    /////
  }

  Future<void> _registraHistoricoPedido(
      {String idPedido,
      String campoAlterado,
      String valorNovo,
      String valorAnterior}) {
    //
    Map<String, dynamic> mapHistorico = {
      "userId": _appController.userAtualDocRef.id,
      "userName": _authController.userAtual.nome,
      "origem": "App", //  "App" OR "PC"
      "dataHora": DateTime.now().millisecondsSinceEpoch,
      "campo": campoAlterado,
      "anterior": valorAnterior,
      "novo": valorNovo,
    };

    _appController.cnpjAtivoDocRef
        .collection('pedidos')
        .doc(idPedido)
        .collection('historico')
        .add(mapHistorico);

    print(' >> pedido page Repository.REGISTRA HISTORICO PEDIDO ');
    return null;
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
