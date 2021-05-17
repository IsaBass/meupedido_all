// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'empresas_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EmpresasController on _EmpresasBase, Store {
  final _$isLoadingAtom = Atom(name: '_EmpresasBase.isLoading');

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

  final _$listaEmpAtom = Atom(name: '_EmpresasBase.listaEmp');

  @override
  ObservableList<CnpjModel> get listaEmp {
    _$listaEmpAtom.reportRead();
    return super.listaEmp;
  }

  @override
  set listaEmp(ObservableList<CnpjModel> value) {
    _$listaEmpAtom.reportWrite(value, super.listaEmp, () {
      super.listaEmp = value;
    });
  }

  final _$carregaEmpresasAsyncAction =
      AsyncAction('_EmpresasBase.carregaEmpresas');

  @override
  Future carregaEmpresas() {
    return _$carregaEmpresasAsyncAction.run(() => super.carregaEmpresas());
  }

  final _$_getAllEmpresasAsyncAction =
      AsyncAction('_EmpresasBase._getAllEmpresas');

  @override
  Future<List<CnpjModel>> _getAllEmpresas() {
    return _$_getAllEmpresasAsyncAction.run(() => super._getAllEmpresas());
  }

  final _$saveEmpresaAsyncAction = AsyncAction('_EmpresasBase.saveEmpresa');

  @override
  Future<dynamic> saveEmpresa(CnpjModel emp) {
    return _$saveEmpresaAsyncAction.run(() => super.saveEmpresa(emp));
  }

  final _$saveNovaEmpresaAsyncAction =
      AsyncAction('_EmpresasBase.saveNovaEmpresa');

  @override
  Future<dynamic> saveNovaEmpresa(CnpjModel emp) {
    return _$saveNovaEmpresaAsyncAction.run(() => super.saveNovaEmpresa(emp));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
listaEmp: ${listaEmp}
    ''';
  }
}
