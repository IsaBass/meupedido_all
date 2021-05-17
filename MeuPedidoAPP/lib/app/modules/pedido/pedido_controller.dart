import 'package:mobx/mobx.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'repository/pedido_interf_repository.dart';

part 'pedido_controller.g.dart';

class PedidoController = _PedidoBase with _$PedidoController;

abstract class _PedidoBase with Store {
  final IPedidoRepository _repository;

  
  _PedidoBase(this._repository) ;

  //
  @observable
  bool isLoading = false;
  @action
  void setLoading(bool v) => isLoading = v;
  //

  @observable
  ObservableStream<Map<String, dynamic>> pedido;
  
  @action
  getPedido(String idPedido) {
    pedido = _repository.getPedido(idPedido).asObservable(initialValue: {});
  }

  @action
  Future<Map> pedirCancelamento(Pedido pedido, String motivo) async {
    isLoading = true;

    // ainda nao aceito e com pagamento pessoal => cancela logo
    if (pedido.status == '0' && pedido.pagamentos[0].forma == 'INLOCO') {
      //
      _repository.cancelePedido(pedido.docId, motivo, pedido.status);
      isLoading = false;
      return {"resposta": "success"};
      //
    }
    //
    if (pedido.status == '0' && pedido.pagamentos[0].forma == 'ONLINE') {
      //TODO: CANCELAR CARTÃO DE CREDITO
      if (pedido.pagamentos[0].codPag == 'MercadoPago') {
        //TODO: CHAMAR CANCELAMENTO DO MERCADO PAGO E VERIFICAR SUCESSO
      }
      if (pedido.pagamentos[0].codPag == 'Cielo') {
        //TODO: CHAMAR CANCELAMENTO DO CIELO E VERIFICAR SUCESSO
      }
      //
      _repository.cancelePedido(pedido.docId, motivo, pedido.status);
      isLoading = false;
      return {"resposta": "success"};
      //
    }
    //
    if (pedido.status != '0') {
      //
      _repository.cancelePendentePedido(pedido.docId, motivo, pedido.status);
      isLoading = false;
      return {"resposta": "pendente"};
      //
    }

    //
    isLoading = false;
    return {"resposta": "NEGADO"};
    //
  }
}
