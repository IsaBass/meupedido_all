// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categs_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CategsController on _CategsControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_CategsControllerBase.isLoading');

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

  final _$categsAtom = Atom(name: '_CategsControllerBase.categs');

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
      AsyncAction('_CategsControllerBase.recarregaAllCategs');

  @override
  Future<void> recarregaAllCategs() {
    return _$recarregaAllCategsAsyncAction
        .run(() => super.recarregaAllCategs());
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
categs: ${categs}
    ''';
  }
}
