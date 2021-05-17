// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SearchController on _SearchControllerBase, Store {
  final _$prodsAtom = Atom(name: '_SearchControllerBase.prods');

  @override
  ObservableList<ProdutoModel> get prods {
    _$prodsAtom.reportRead();
    return super.prods;
  }

  @override
  set prods(ObservableList<ProdutoModel> value) {
    _$prodsAtom.reportWrite(value, super.prods, () {
      super.prods = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_SearchControllerBase.isLoading');

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

  final _$buscaProdutoAsyncAction =
      AsyncAction('_SearchControllerBase.buscaProduto');

  @override
  Future<void> buscaProduto(String filtro) {
    return _$buscaProdutoAsyncAction.run(() => super.buscaProduto(filtro));
  }

  @override
  String toString() {
    return '''
prods: ${prods},
isLoading: ${isLoading}
    ''';
  }
}
