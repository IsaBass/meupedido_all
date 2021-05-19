// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$favoritosAtom = Atom(name: '_AuthControllerBase.favoritos');

  @override
  ObservableList<String> get favoritos {
    _$favoritosAtom.reportRead();
    return super.favoritos;
  }

  @override
  set favoritos(ObservableList<String> value) {
    _$favoritosAtom.reportWrite(value, super.favoritos, () {
      super.favoritos = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AuthControllerBase.isLoading');

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

  final _$changeFavoritoAsyncAction =
      AsyncAction('_AuthControllerBase.changeFavorito');

  @override
  Future<void> changeFavorito(UserModel user, String idProduto, String cnpj) {
    return _$changeFavoritoAsyncAction
        .run(() => super.changeFavorito(user, idProduto, cnpj));
  }

  final _$loginEmailSenhaAsyncAction =
      AsyncAction('_AuthControllerBase.loginEmailSenha');

  @override
  Future<Rsp<UserModel>> loginEmailSenha(
      {String email, String pass, String cnpj}) {
    return _$loginEmailSenhaAsyncAction
        .run(() => super.loginEmailSenha(email: email, pass: pass, cnpj: cnpj));
  }

  final _$createLoginEmailSenhaAsyncAction =
      AsyncAction('_AuthControllerBase.createLoginEmailSenha');

  @override
  Future<Rsp<UserModel>> createLoginEmailSenha(
      {String email,
      String pass,
      String cnpj,
      VoidCallback onSucces,
      VoidCallback onFail}) {
    return _$createLoginEmailSenhaAsyncAction.run(() => super
        .createLoginEmailSenha(
            email: email,
            pass: pass,
            cnpj: cnpj,
            onSucces: onSucces,
            onFail: onFail));
  }

  final _$loadCurrentUserAsyncAction =
      AsyncAction('_AuthControllerBase.loadCurrentUser');

  @override
  Future<Rsp<UserModel>> loadCurrentUser(String cnpj) {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser(cnpj));
  }

  final _$recarregaUserEmpresasAsyncAction =
      AsyncAction('_AuthControllerBase.recarregaUserEmpresas');

  @override
  Future<UserModel> recarregaUserEmpresas(String uid, String cnpj) {
    return _$recarregaUserEmpresasAsyncAction
        .run(() => super.recarregaUserEmpresas(uid, cnpj));
  }

  final _$tornarEmpresaPadraoAsyncAction =
      AsyncAction('_AuthControllerBase.tornarEmpresaPadrao');

  @override
  Future<dynamic> tornarEmpresaPadrao(UserModel userAtual, String cnpj) {
    return _$tornarEmpresaPadraoAsyncAction
        .run(() => super.tornarEmpresaPadrao(userAtual, cnpj));
  }

  final _$signOutAsyncAction = AsyncAction('_AuthControllerBase.signOut');

  @override
  Future<Rsp<Object>> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$recoveryPassAsyncAction =
      AsyncAction('_AuthControllerBase.recoveryPass');

  @override
  Future<void> recoveryPass(
      {String email, VoidCallback onSucces, VoidCallback onFail}) {
    return _$recoveryPassAsyncAction.run(() =>
        super.recoveryPass(email: email, onSucces: onSucces, onFail: onFail));
  }

  final _$createLoginGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.createLoginGoogle');

  @override
  Future<Rsp<UserModel>> createLoginGoogle(
      {GoogleSignInAccount userGoogle,
      String cnpj,
      VoidCallback onSucces,
      VoidCallback onFail}) {
    return _$createLoginGoogleAsyncAction.run(() => super.createLoginGoogle(
        userGoogle: userGoogle,
        cnpj: cnpj,
        onSucces: onSucces,
        onFail: onFail));
  }

  final _$logarGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.logarGoogle');

  @override
  Future<Rsp<UserModel>> logarGoogle(
      {String cnpj, VoidCallback onSucces, VoidCallback onFail}) {
    return _$logarGoogleAsyncAction.run(() =>
        super.logarGoogle(cnpj: cnpj, onSucces: onSucces, onFail: onFail));
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  void setLoading() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setLoading');
    try {
      return super.setLoading();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNoLoading() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setNoLoading');
    try {
      return super.setNoLoading();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favoritos: ${favoritos},
isLoading: ${isLoading}
    ''';
  }
}
