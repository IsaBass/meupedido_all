// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_enderecos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListEnderecosController on _ListEnderecosControllerBase, Store {
  final _$isLoadingAtom = Atom(name: '_ListEnderecosControllerBase.isLoading');

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

  final _$enderecosAtom = Atom(name: '_ListEnderecosControllerBase.enderecos');

  @override
  ObservableList<EnderecoModel> get enderecos {
    _$enderecosAtom.reportRead();
    return super.enderecos;
  }

  @override
  set enderecos(ObservableList<EnderecoModel> value) {
    _$enderecosAtom.reportWrite(value, super.enderecos, () {
      super.enderecos = value;
    });
  }

  final _$getEnderecosAsyncAction =
      AsyncAction('_ListEnderecosControllerBase.getEnderecos');

  @override
  Future<void> getEnderecos() {
    return _$getEnderecosAsyncAction.run(() => super.getEnderecos());
  }

  final _$excluiEnderecoAsyncAction =
      AsyncAction('_ListEnderecosControllerBase.excluiEndereco');

  @override
  Future<void> excluiEndereco(EnderecoModel end) {
    return _$excluiEnderecoAsyncAction.run(() => super.excluiEndereco(end));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
enderecos: ${enderecos}
    ''';
  }
}
