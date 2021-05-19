// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartModel on _CartModelBase, Store {
  Computed<int> _$qtdItensComputed;

  @override
  int get qtdItens => (_$qtdItensComputed ??=
          Computed<int>(() => super.qtdItens, name: '_CartModelBase.qtdItens'))
      .value;
  Computed<double> _$valorTotalComputed;

  @override
  double get valorTotal =>
      (_$valorTotalComputed ??= Computed<double>(() => super.valorTotal,
              name: '_CartModelBase.valorTotal'))
          .value;
  Computed<double> _$descontoValorComputed;

  @override
  double get descontoValor =>
      (_$descontoValorComputed ??= Computed<double>(() => super.descontoValor,
              name: '_CartModelBase.descontoValor'))
          .value;
  Computed<double> _$descontoPercComputed;

  @override
  double get descontoPerc =>
      (_$descontoPercComputed ??= Computed<double>(() => super.descontoPerc,
              name: '_CartModelBase.descontoPerc'))
          .value;
  Computed<double> _$valorProdutosComputed;

  @override
  double get valorProdutos =>
      (_$valorProdutosComputed ??= Computed<double>(() => super.valorProdutos,
              name: '_CartModelBase.valorProdutos'))
          .value;

  final _$idUserAtom = Atom(name: '_CartModelBase.idUser');

  @override
  String get idUser {
    _$idUserAtom.reportRead();
    return super.idUser;
  }

  @override
  set idUser(String value) {
    _$idUserAtom.reportWrite(value, super.idUser, () {
      super.idUser = value;
    });
  }

  final _$cupomAplicadoAtom = Atom(name: '_CartModelBase.cupomAplicado');

  @override
  CupomDesconto get cupomAplicado {
    _$cupomAplicadoAtom.reportRead();
    return super.cupomAplicado;
  }

  @override
  set cupomAplicado(CupomDesconto value) {
    _$cupomAplicadoAtom.reportWrite(value, super.cupomAplicado, () {
      super.cupomAplicado = value;
    });
  }

  final _$vlrFreteAtom = Atom(name: '_CartModelBase.vlrFrete');

  @override
  double get vlrFrete {
    _$vlrFreteAtom.reportRead();
    return super.vlrFrete;
  }

  @override
  set vlrFrete(double value) {
    _$vlrFreteAtom.reportWrite(value, super.vlrFrete, () {
      super.vlrFrete = value;
    });
  }

  final _$itensAtom = Atom(name: '_CartModelBase.itens');

  @override
  ObservableList<CartItemModel> get itens {
    _$itensAtom.reportRead();
    return super.itens;
  }

  @override
  set itens(ObservableList<CartItemModel> value) {
    _$itensAtom.reportWrite(value, super.itens, () {
      super.itens = value;
    });
  }

  final _$_CartModelBaseActionController =
      ActionController(name: '_CartModelBase');

  @override
  void adicionarItem(CartItemModel item) {
    final _$actionInfo = _$_CartModelBaseActionController.startAction(
        name: '_CartModelBase.adicionarItem');
    try {
      return super.adicionarItem(item);
    } finally {
      _$_CartModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removerItem(CartItemModel item) {
    final _$actionInfo = _$_CartModelBaseActionController.startAction(
        name: '_CartModelBase.removerItem');
    try {
      return super.removerItem(item);
    } finally {
      _$_CartModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setVlrFrete(double vlr) {
    final _$actionInfo = _$_CartModelBaseActionController.startAction(
        name: '_CartModelBase.setVlrFrete');
    try {
      return super.setVlrFrete(vlr);
    } finally {
      _$_CartModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
idUser: ${idUser},
cupomAplicado: ${cupomAplicado},
vlrFrete: ${vlrFrete},
itens: ${itens},
qtdItens: ${qtdItens},
valorTotal: ${valorTotal},
descontoValor: ${descontoValor},
descontoPerc: ${descontoPerc},
valorProdutos: ${valorProdutos}
    ''';
  }
}
