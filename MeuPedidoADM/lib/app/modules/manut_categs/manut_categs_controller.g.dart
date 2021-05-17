// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manut_categs_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ManutCategsController on _ManutCategsBase, Store {
  final _$isLoadingAtom = Atom(name: '_ManutCategsBase.isLoading');

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

  final _$isLoadingListAtom = Atom(name: '_ManutCategsBase.isLoadingList');

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

  final _$categsAtom = Atom(name: '_ManutCategsBase.categs');

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

  final _$recarregaAllCategsAsyncAction =
      AsyncAction('_ManutCategsBase.recarregaAllCategs');

  @override
  Future<void> recarregaAllCategs() {
    return _$recarregaAllCategsAsyncAction
        .run(() => super.recarregaAllCategs());
  }

  final _$updateCategAsyncAction = AsyncAction('_ManutCategsBase.updateCateg');

  @override
  Future<void> updateCateg(CategoriaModel categ) {
    return _$updateCategAsyncAction.run(() => super.updateCateg(categ));
  }

  final _$excluirCategAsyncAction =
      AsyncAction('_ManutCategsBase.excluirCateg');

  @override
  Future<void> excluirCateg(CategoriaModel categ) {
    return _$excluirCategAsyncAction.run(() => super.excluirCateg(categ));
  }

  final _$existeProdCategAsyncAction =
      AsyncAction('_ManutCategsBase.existeProdCateg');

  @override
  Future<bool> existeProdCateg(CategoriaModel categ) {
    return _$existeProdCategAsyncAction.run(() => super.existeProdCateg(categ));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLoadingList: ${isLoadingList},
categs: ${categs}
    ''';
  }
}
