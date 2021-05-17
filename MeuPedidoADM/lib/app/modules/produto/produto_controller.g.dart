// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProdutoController on _ProdutoBase, Store {
  final _$isLoadingAtom = Atom(name: '_ProdutoBase.isLoading');

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

  final _$saveProdAsyncAction = AsyncAction('_ProdutoBase.saveProd');

  @override
  Future<dynamic> saveProd(ProdutoModel prod) {
    return _$saveProdAsyncAction.run(() => super.saveProd(prod));
  }

  final _$_updateProdAsyncAction = AsyncAction('_ProdutoBase._updateProd');

  @override
  Future<dynamic> _updateProd(ProdutoModel prod) {
    return _$_updateProdAsyncAction.run(() => super._updateProd(prod));
  }

  final _$_novoProdAsyncAction = AsyncAction('_ProdutoBase._novoProd');

  @override
  Future<dynamic> _novoProd(ProdutoModel prod) {
    return _$_novoProdAsyncAction.run(() => super._novoProd(prod));
  }

  final _$getOpcionaisAsyncAction = AsyncAction('_ProdutoBase.getOpcionais');

  @override
  Future<dynamic> getOpcionais(ProdutoModel prod, String idCateg) {
    return _$getOpcionaisAsyncAction
        .run(() => super.getOpcionais(prod, idCateg));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
