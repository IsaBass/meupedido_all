// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configs_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ConfigsController on _ConfigsBase, Store {
  final _$isLoadingAtom = Atom(name: '_ConfigsBase.isLoading');

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

  final _$saveUserDataAsyncAction = AsyncAction('_ConfigsBase.saveUserData');

  @override
  Future<void> saveUserData() {
    return _$saveUserDataAsyncAction.run(() => super.saveUserData());
  }

  final _$adicioneEmpresaAsyncAction =
      AsyncAction('_ConfigsBase.adicioneEmpresa');

  @override
  Future<dynamic> adicioneEmpresa(
      String novoCNPJ, dynamic Function(String) onFail, Function onSucesso) {
    return _$adicioneEmpresaAsyncAction
        .run(() => super.adicioneEmpresa(novoCNPJ, onFail, onSucesso));
  }

  final _$tornarEmpresaPadraoAsyncAction =
      AsyncAction('_ConfigsBase.tornarEmpresaPadrao');

  @override
  Future<dynamic> tornarEmpresaPadrao(String cnpj) {
    return _$tornarEmpresaPadraoAsyncAction
        .run(() => super.tornarEmpresaPadrao(cnpj));
  }

  final _$excluiEmpresaAsyncAction = AsyncAction('_ConfigsBase.excluiEmpresa');

  @override
  Future<void> excluiEmpresa(UserEmpresa e) {
    return _$excluiEmpresaAsyncAction.run(() => super.excluiEmpresa(e));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
