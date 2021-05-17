// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usuarios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UsuariosController on _UsuariosBase, Store {
  final _$listaUsuariosAtom = Atom(name: '_UsuariosBase.listaUsuarios');

  @override
  ObservableList<UserModel> get listaUsuarios {
    _$listaUsuariosAtom.reportRead();
    return super.listaUsuarios;
  }

  @override
  set listaUsuarios(ObservableList<UserModel> value) {
    _$listaUsuariosAtom.reportWrite(value, super.listaUsuarios, () {
      super.listaUsuarios = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_UsuariosBase.isLoading');

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

  final _$getAllUsuariosAsyncAction =
      AsyncAction('_UsuariosBase.getAllUsuarios');

  @override
  Future<List<UserModel>> getAllUsuarios(String cnpj) {
    return _$getAllUsuariosAsyncAction.run(() => super.getAllUsuarios(cnpj));
  }

  final _$salvarUserAsyncAction = AsyncAction('_UsuariosBase.salvarUser');

  @override
  Future<dynamic> salvarUser(UserModel user) {
    return _$salvarUserAsyncAction.run(() => super.salvarUser(user));
  }

  final _$_UsuariosBaseActionController =
      ActionController(name: '_UsuariosBase');

  @override
  void setPerfil(UserModel usu, Perfil perfil) {
    final _$actionInfo = _$_UsuariosBaseActionController.startAction(
        name: '_UsuariosBase.setPerfil');
    try {
      return super.setPerfil(usu, perfil);
    } finally {
      _$_UsuariosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatusEmpresa(UserModel usu, String status) {
    final _$actionInfo = _$_UsuariosBaseActionController.startAction(
        name: '_UsuariosBase.setStatusEmpresa');
    try {
      return super.setStatusEmpresa(usu, status);
    } finally {
      _$_UsuariosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaUsuarios: ${listaUsuarios},
isLoading: ${isLoading}
    ''';
  }
}
