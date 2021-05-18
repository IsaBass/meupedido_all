import 'package:MeuPedido/app/modules/home/tabs/meuspedidos/meuspedidos_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';

import 'meupedido_model.dart';

part 'meuspedidos_controller.g.dart';

class MeusPedidosController = _MeusPedidosControllerBase
    with _$MeusPedidosController;

abstract class _MeusPedidosControllerBase with Store {
  // final AppController _appController = AppModule.to.get();
  final MeusPedidosRepository _repository;

  @observable
  bool isLoading = false;

  @observable
  ObservableList<MeuPedido> pedidos;

  _MeusPedidosControllerBase(this._repository);

  @action
  Future<void> getMeusPedidos() async {
    isLoading = true;
    //
    var lAux = <MeuPedido>[];

    var docs = await _repository.getPedidos();

    for (var doc in docs) {
      lAux.add(MeuPedido.fromJson(doc));
    }

    pedidos = lAux.asObservable();
    isLoading = false;
  }

  @action
  Stream<QuerySnapshot> streamMeusPedidos() => _repository.streamPedidos();

  @action
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamPedidoUnico(
          String idPedido) =>
      _repository.streamPedidoUnico(idPedido);
}
