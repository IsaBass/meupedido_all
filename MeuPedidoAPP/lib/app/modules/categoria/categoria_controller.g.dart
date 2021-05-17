// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategoriaController on _CategoriaBase, Store {
  Computed<String> _$nomeSelecionadaComputed;

  @override
  String get nomeSelecionada => (_$nomeSelecionadaComputed ??= Computed<String>(
          () => super.nomeSelecionada,
          name: '_CategoriaBase.nomeSelecionada'))
      .value;

  final _$isLoadingAtom = Atom(name: '_CategoriaBase.isLoading');

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

  final _$listProdsAtom = Atom(name: '_CategoriaBase.listProds');

  @override
  ObservableList<ProdutoModel> get listProds {
    _$listProdsAtom.reportRead();
    return super.listProds;
  }

  @override
  set listProds(ObservableList<ProdutoModel> value) {
    _$listProdsAtom.reportWrite(value, super.listProds, () {
      super.listProds = value;
    });
  }

  final _$listDestaquesAtom = Atom(name: '_CategoriaBase.listDestaques');

  @override
  ObservableList<ProdutoModel> get listDestaques {
    _$listDestaquesAtom.reportRead();
    return super.listDestaques;
  }

  @override
  set listDestaques(ObservableList<ProdutoModel> value) {
    _$listDestaquesAtom.reportWrite(value, super.listDestaques, () {
      super.listDestaques = value;
    });
  }

  final _$codCategSelecionadaAtom =
      Atom(name: '_CategoriaBase.codCategSelecionada');

  @override
  int get codCategSelecionada {
    _$codCategSelecionadaAtom.reportRead();
    return super.codCategSelecionada;
  }

  @override
  set codCategSelecionada(int value) {
    _$codCategSelecionadaAtom.reportWrite(value, super.codCategSelecionada, () {
      super.codCategSelecionada = value;
    });
  }

  final _$prodsDestaqueGeralAtom =
      Atom(name: '_CategoriaBase.prodsDestaqueGeral');

  @override
  ObservableList<ProdutoModel> get prodsDestaqueGeral {
    _$prodsDestaqueGeralAtom.reportRead();
    return super.prodsDestaqueGeral;
  }

  @override
  set prodsDestaqueGeral(ObservableList<ProdutoModel> value) {
    _$prodsDestaqueGeralAtom.reportWrite(value, super.prodsDestaqueGeral, () {
      super.prodsDestaqueGeral = value;
    });
  }

  final _$prodsTodosDestaqueAtom =
      Atom(name: '_CategoriaBase.prodsTodosDestaque');

  @override
  ObservableList<ProdutoModel> get prodsTodosDestaque {
    _$prodsTodosDestaqueAtom.reportRead();
    return super.prodsTodosDestaque;
  }

  @override
  set prodsTodosDestaque(ObservableList<ProdutoModel> value) {
    _$prodsTodosDestaqueAtom.reportWrite(value, super.prodsTodosDestaque, () {
      super.prodsTodosDestaque = value;
    });
  }

  final _$setCategSelecionadaAsyncAction =
      AsyncAction('_CategoriaBase.setCategSelecionada');

  @override
  Future<void> setCategSelecionada(int cod) {
    return _$setCategSelecionadaAsyncAction
        .run(() => super.setCategSelecionada(cod));
  }

  final _$fetchProdsCategoriaAsyncAction =
      AsyncAction('_CategoriaBase.fetchProdsCategoria');

  @override
  Future<void> fetchProdsCategoria() {
    return _$fetchProdsCategoriaAsyncAction
        .run(() => super.fetchProdsCategoria());
  }

  final _$fetchProdsDestaqueGeralAsyncAction =
      AsyncAction('_CategoriaBase.fetchProdsDestaqueGeral');

  @override
  Future<void> fetchProdsDestaqueGeral() {
    return _$fetchProdsDestaqueGeralAsyncAction
        .run(() => super.fetchProdsDestaqueGeral());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
listProds: ${listProds},
listDestaques: ${listDestaques},
codCategSelecionada: ${codCategSelecionada},
prodsDestaqueGeral: ${prodsDestaqueGeral},
prodsTodosDestaque: ${prodsTodosDestaque},
nomeSelecionada: ${nomeSelecionada}
    ''';
  }
}
