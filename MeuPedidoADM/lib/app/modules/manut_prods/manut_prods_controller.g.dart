// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manut_prods_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ManutProdsController on _ManutProdsBase, Store {
  final _$isLoadingAtom = Atom(name: '_ManutProdsBase.isLoading');

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

  final _$isLoadingListAtom = Atom(name: '_ManutProdsBase.isLoadingList');

  @override
  bool get isLoadingList {
    _$isLoadingListAtom.reportRead();
    return super.isLoadingList;
  }

  @override
  set isLoadingList(bool value) {
    _$isLoadingListAtom.reportWrite(value, super.isLoadingList, () {
      super.isLoadingList = value;
    });
  }

  final _$categSelecionadaAtom = Atom(name: '_ManutProdsBase.categSelecionada');

  @override
  CategoriaModel get categSelecionada {
    _$categSelecionadaAtom.reportRead();
    return super.categSelecionada;
  }

  @override
  set categSelecionada(CategoriaModel value) {
    _$categSelecionadaAtom.reportWrite(value, super.categSelecionada, () {
      super.categSelecionada = value;
    });
  }

  final _$categsAtom = Atom(name: '_ManutProdsBase.categs');

  @override
  ObservableList<CategoriaModel> get categs {
    _$categsAtom.reportRead();
    return super.categs;
  }

  @override
  set categs(ObservableList<CategoriaModel> value) {
    _$categsAtom.reportWrite(value, super.categs, () {
      super.categs = value;
    });
  }

  final _$prodsAtom = Atom(name: '_ManutProdsBase.prods');

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

  final _$recarregaAllCategsAsyncAction =
      AsyncAction('_ManutProdsBase.recarregaAllCategs');

  @override
  Future<void> recarregaAllCategs() {
    return _$recarregaAllCategsAsyncAction
        .run(() => super.recarregaAllCategs());
  }

  final _$setCategSelecionadaAsyncAction =
      AsyncAction('_ManutProdsBase.setCategSelecionada');

  @override
  Future<void> setCategSelecionada(CategoriaModel categ) {
    return _$setCategSelecionadaAsyncAction
        .run(() => super.setCategSelecionada(categ));
  }

  final _$carregaProdsAsyncAction = AsyncAction('_ManutProdsBase.carregaProds');

  @override
  Future<void> carregaProds() {
    return _$carregaProdsAsyncAction.run(() => super.carregaProds());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLoadingList: ${isLoadingList},
categSelecionada: ${categSelecionada},
categs: ${categs},
prods: ${prods}
    ''';
  }
}
