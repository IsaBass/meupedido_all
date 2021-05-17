// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proddetails_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProddetailsController on _ProddetailsBase, Store {
  Computed<double> _$valorTotalComputed;

  @override
  double get valorTotal =>
      (_$valorTotalComputed ??= Computed<double>(() => super.valorTotal,
              name: '_ProddetailsBase.valorTotal'))
          .value;

  final _$prodAtom = Atom(name: '_ProddetailsBase.prod');

  @override
  ProdutoModel get prod {
    _$prodAtom.reportRead();
    return super.prod;
  }

  @override
  set prod(ProdutoModel value) {
    _$prodAtom.reportWrite(value, super.prod, () {
      super.prod = value;
    });
  }

  final _$quantidadeAtom = Atom(name: '_ProddetailsBase.quantidade');

  @override
  double get quantidade {
    _$quantidadeAtom.reportRead();
    return super.quantidade;
  }

  @override
  set quantidade(double value) {
    _$quantidadeAtom.reportWrite(value, super.quantidade, () {
      super.quantidade = value;
    });
  }

  final _$getProdutoAsyncAction = AsyncAction('_ProddetailsBase.getProduto');

  @override
  Future<ProdutoModel> getProduto(String codigo) {
    return _$getProdutoAsyncAction.run(() => super.getProduto(codigo));
  }

  final _$_ProddetailsBaseActionController =
      ActionController(name: '_ProddetailsBase');

  @override
  void updFalso() {
    final _$actionInfo = _$_ProddetailsBaseActionController.startAction(
        name: '_ProddetailsBase.updFalso');
    try {
      return super.updFalso();
    } finally {
      _$_ProddetailsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_ProddetailsBaseActionController.startAction(
        name: '_ProddetailsBase.increment');
    try {
      return super.increment();
    } finally {
      _$_ProddetailsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrement() {
    final _$actionInfo = _$_ProddetailsBaseActionController.startAction(
        name: '_ProddetailsBase.decrement');
    try {
      return super.decrement();
    } finally {
      _$_ProddetailsBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
prod: ${prod},
quantidade: ${quantidade},
valorTotal: ${valorTotal}
    ''';
  }
}
