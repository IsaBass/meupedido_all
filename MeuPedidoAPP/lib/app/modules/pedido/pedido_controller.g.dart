// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PedidoController on _PedidoBase, Store {
  final _$isLoadingAtom = Atom(name: '_PedidoBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$pedidoAtom = Atom(name: '_PedidoBase.pedido');

  @override
  ObservableStream<Map<String, dynamic>> get pedido {
    _$pedidoAtom.reportRead();
    return super.pedido;
  }

  @override
  set pedido(ObservableStream<Map<String, dynamic>> value) {
    _$pedidoAtom.reportWrite(value, super.pedido, () {
      super.pedido = value;
    });
  }

  final _$pedirCancelamentoAsyncAction =
      AsyncAction('_PedidoBase.pedirCancelamento');

  @override
  Future<Map<dynamic, dynamic>> pedirCancelamento(
      Pedido pedido, String motivo) {
    return _$pedirCancelamentoAsyncAction
        .run(() => super.pedirCancelamento(pedido, motivo));
  }

  final _$_PedidoBaseActionController = ActionController(name: '_PedidoBase');

  @override
  void setLoading(bool v) {
    final _$actionInfo = _$_PedidoBaseActionController.startAction(
        name: '_PedidoBase.setLoading');
    try {
      return super.setLoading(v);
    } finally {
      _$_PedidoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getPedido(String idPedido) {
    final _$actionInfo = _$_PedidoBaseActionController.startAction(
        name: '_PedidoBase.getPedido');
    try {
      return super.getPedido(idPedido);
    } finally {
      _$_PedidoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pedido: ${pedido}
    ''';
  }
}
