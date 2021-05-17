// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'carrinho_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CarrinhoController on _CarrinhoBase, Store {
  final _$isLoadingAtom = Atom(name: '_CarrinhoBase.isLoading');

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

  final _$tipoEntregaAtom = Atom(name: '_CarrinhoBase.tipoEntrega');

  @override
  String get tipoEntrega {
    _$tipoEntregaAtom.reportRead();
    return super.tipoEntrega;
  }

  @override
  set tipoEntrega(String value) {
    _$tipoEntregaAtom.reportWrite(value, super.tipoEntrega, () {
      super.tipoEntrega = value;
    });
  }

  final _$cupomAceitoAtom = Atom(name: '_CarrinhoBase.cupomAceito');

  @override
  String get cupomAceito {
    _$cupomAceitoAtom.reportRead();
    return super.cupomAceito;
  }

  @override
  set cupomAceito(String value) {
    _$cupomAceitoAtom.reportWrite(value, super.cupomAceito, () {
      super.cupomAceito = value;
    });
  }

  final _$isLoadingCupomAtom = Atom(name: '_CarrinhoBase.isLoadingCupom');

  @override
  bool get isLoadingCupom {
    _$isLoadingCupomAtom.reportRead();
    return super.isLoadingCupom;
  }

  @override
  set isLoadingCupom(bool value) {
    _$isLoadingCupomAtom.reportWrite(value, super.isLoadingCupom, () {
      super.isLoadingCupom = value;
    });
  }

  final _$idEnderecoAtom = Atom(name: '_CarrinhoBase.idEndereco');

  @override
  String get idEndereco {
    _$idEnderecoAtom.reportRead();
    return super.idEndereco;
  }

  @override
  set idEndereco(String value) {
    _$idEnderecoAtom.reportWrite(value, super.idEndereco, () {
      super.idEndereco = value;
    });
  }

  final _$enderecosAtom = Atom(name: '_CarrinhoBase.enderecos');

  @override
  ObservableList<EnderecoModel> get enderecos {
    _$enderecosAtom.reportRead();
    return super.enderecos;
  }

  @override
  set enderecos(ObservableList<EnderecoModel> value) {
    _$enderecosAtom.reportWrite(value, super.enderecos, () {
      super.enderecos = value;
    });
  }

  final _$formaPagamentoAtom = Atom(name: '_CarrinhoBase.formaPagamento');

  @override
  String get formaPagamento {
    _$formaPagamentoAtom.reportRead();
    return super.formaPagamento;
  }

  @override
  set formaPagamento(String value) {
    _$formaPagamentoAtom.reportWrite(value, super.formaPagamento, () {
      super.formaPagamento = value;
    });
  }

  final _$tipoPagamentoAtom = Atom(name: '_CarrinhoBase.tipoPagamento');

  @override
  String get tipoPagamento {
    _$tipoPagamentoAtom.reportRead();
    return super.tipoPagamento;
  }

  @override
  set tipoPagamento(String value) {
    _$tipoPagamentoAtom.reportWrite(value, super.tipoPagamento, () {
      super.tipoPagamento = value;
    });
  }

  final _$gravarPedidoAsyncAction = AsyncAction('_CarrinhoBase.gravarPedido');

  @override
  Future<String> gravarPedido(Pedido pedido) {
    return _$gravarPedidoAsyncAction.run(() => super.gravarPedido(pedido));
  }

  final _$gravarPedidoTemporarioAsyncAction =
      AsyncAction('_CarrinhoBase.gravarPedidoTemporario');

  @override
  Future<String> gravarPedidoTemporario() {
    return _$gravarPedidoTemporarioAsyncAction
        .run(() => super.gravarPedidoTemporario());
  }

  final _$excluirPedidoTemporarioAsyncAction =
      AsyncAction('_CarrinhoBase.excluirPedidoTemporario');

  @override
  Future<void> excluirPedidoTemporario(String idPedido) {
    return _$excluirPedidoTemporarioAsyncAction
        .run(() => super.excluirPedidoTemporario(idPedido));
  }

  final _$getEnderecosAsyncAction = AsyncAction('_CarrinhoBase.getEnderecos');

  @override
  Future<void> getEnderecos() {
    return _$getEnderecosAsyncAction.run(() => super.getEnderecos());
  }

  final _$excluiEnderecoAsyncAction =
      AsyncAction('_CarrinhoBase.excluiEndereco');

  @override
  Future<void> excluiEndereco(EnderecoModel end) {
    return _$excluiEnderecoAsyncAction.run(() => super.excluiEndereco(end));
  }

  final _$getCupomAsyncAction = AsyncAction('_CarrinhoBase.getCupom');

  @override
  Future<Map<dynamic, dynamic>> getCupom(String tagCupom) {
    return _$getCupomAsyncAction.run(() => super.getCupom(tagCupom));
  }

  final _$calculeFreteAsyncAction = AsyncAction('_CarrinhoBase.calculeFrete');

  @override
  Future<void> calculeFrete({EnderecoModel endereco = null}) {
    return _$calculeFreteAsyncAction
        .run(() => super.calculeFrete(endereco: endereco));
  }

  final _$_CarrinhoBaseActionController =
      ActionController(name: '_CarrinhoBase');

  @override
  void setTipoEntrega(String novo) {
    final _$actionInfo = _$_CarrinhoBaseActionController.startAction(
        name: '_CarrinhoBase.setTipoEntrega');
    try {
      return super.setTipoEntrega(novo);
    } finally {
      _$_CarrinhoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCodEndereco(String novo) {
    final _$actionInfo = _$_CarrinhoBaseActionController.startAction(
        name: '_CarrinhoBase.setCodEndereco');
    try {
      return super.setCodEndereco(novo);
    } finally {
      _$_CarrinhoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setformaPagamento(String novo) {
    final _$actionInfo = _$_CarrinhoBaseActionController.startAction(
        name: '_CarrinhoBase.setformaPagamento');
    try {
      return super.setformaPagamento(novo);
    } finally {
      _$_CarrinhoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTipoPagamento(String novo) {
    final _$actionInfo = _$_CarrinhoBaseActionController.startAction(
        name: '_CarrinhoBase.setTipoPagamento');
    try {
      return super.setTipoPagamento(novo);
    } finally {
      _$_CarrinhoBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
tipoEntrega: ${tipoEntrega},
cupomAceito: ${cupomAceito},
isLoadingCupom: ${isLoadingCupom},
idEndereco: ${idEndereco},
enderecos: ${enderecos},
formaPagamento: ${formaPagamento},
tipoPagamento: ${tipoPagamento}
    ''';
  }
}
