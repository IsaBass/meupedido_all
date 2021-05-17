// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meuspedidos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MeusPedidosController on _MeusPedidosControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_MeusPedidosControllerBase.isLoading');

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

  final _$pedidosAtom = Atom(name: '_MeusPedidosControllerBase.pedidos');

  @override
  ObservableList<MeuPedido> get pedidos {
    _$pedidosAtom.reportRead();
    return super.pedidos;
  }

  @override
  set pedidos(ObservableList<MeuPedido> value) {
    _$pedidosAtom.reportWrite(value, super.pedidos, () {
      super.pedidos = value;
    });
  }

  final _$getMeusPedidosAsyncAction =
      AsyncAction('_MeusPedidosControllerBase.getMeusPedidos');

  @override
  Future<void> getMeusPedidos() {
    return _$getMeusPedidosAsyncAction.run(() => super.getMeusPedidos());
  }

  final _$_MeusPedidosControllerBaseActionController =
      ActionController(name: '_MeusPedidosControllerBase');

  @override
  Stream<QuerySnapshot> streamMeusPedidos() {
    final _$actionInfo = _$_MeusPedidosControllerBaseActionController
        .startAction(name: '_MeusPedidosControllerBase.streamMeusPedidos');
    try {
      return super.streamMeusPedidos();
    } finally {
      _$_MeusPedidosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  Stream<DocumentSnapshot> streamPedidoUnico(String idPedido) {
    final _$actionInfo = _$_MeusPedidosControllerBaseActionController
        .startAction(name: '_MeusPedidosControllerBase.streamPedidoUnico');
    try {
      return super.streamPedidoUnico(idPedido);
    } finally {
      _$_MeusPedidosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pedidos: ${pedidos}
    ''';
  }
}
