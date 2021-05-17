// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$userAtualAtom = Atom(name: '_AuthControllerBase.userAtual');

  @override
  UserModel get userAtual {
    _$userAtualAtom.reportRead();
    return super.userAtual;
  }

  @override
  set userAtual(UserModel value) {
    _$userAtualAtom.reportWrite(value, super.userAtual, () {
      super.userAtual = value;
    });
  }

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

  final _$estaLogadoAtom = Atom(name: '_AuthControllerBase.estaLogado');

  @override
  bool get estaLogado {
    _$estaLogadoAtom.reportRead();
    return super.estaLogado;
  }

  @override
  set estaLogado(bool value) {
    _$estaLogadoAtom.reportWrite(value, super.estaLogado, () {
      super.estaLogado = value;
    });
  }

  final _$changeFavoritoAsyncAction =
      AsyncAction('_AuthControllerBase.changeFavorito');

  @override
  Future<void> changeFavorito(String idProduto) {
    return _$changeFavoritoAsyncAction
        .run(() => super.changeFavorito(idProduto));
  }

  final _$loadCurrentUserAsyncAction =
      AsyncAction('_AuthControllerBase.loadCurrentUser');

  @override
  Future<Null> loadCurrentUser() {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser());
  }

  final _$recarregaUserEmpresasAsyncAction =
      AsyncAction('_AuthControllerBase.recarregaUserEmpresas');

  @override
  Future<void> recarregaUserEmpresas() {
    return _$recarregaUserEmpresasAsyncAction
        .run(() => super.recarregaUserEmpresas());
  }

  final _$signOutAsyncAction = AsyncAction('_AuthControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$createLoginGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.createLoginGoogle');

  @override
  Future<void> createLoginGoogle(
      {@required GoogleSignInAccount userGoogle,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    return _$createLoginGoogleAsyncAction.run(() => super.createLoginGoogle(
        userGoogle: userGoogle, onSucces: onSucces, onFail: onFail));
  }

  final _$getLoginGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.getLoginGoogle');

  @override
  Future<dynamic> getLoginGoogle({@required bool logar}) {
    return _$getLoginGoogleAsyncAction
        .run(() => super.getLoginGoogle(logar: logar));
  }

  final _$logarGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.logarGoogle');

  @override
  Future<String> logarGoogle(
      {@required VoidCallback onSucces, @required VoidCallback onFail}) {
    return _$logarGoogleAsyncAction
        .run(() => super.logarGoogle(onSucces: onSucces, onFail: onFail));
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
  void setEstaLogado() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setEstaLogado');
    try {
      return super.setEstaLogado();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNaoEstaLogado() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setNaoEstaLogado');
    try {
      return super.setNaoEstaLogado();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void loginEmailSenha(
      {@required String email,
      @required String pass,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.loginEmailSenha');
    try {
      return super.loginEmailSenha(
          email: email, pass: pass, onSucces: onSucces, onFail: onFail);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void createLoginEmailSenha(
      {@required String pass,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.createLoginEmailSenha');
    try {
      return super.createLoginEmailSenha(
          pass: pass, onSucces: onSucces, onFail: onFail);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void recoveryPass(
      {String email,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.recoveryPass');
    try {
      return super
          .recoveryPass(email: email, onSucces: onSucces, onFail: onFail);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userAtual: ${userAtual},
favoritos: ${favoritos},
isLoading: ${isLoading},
estaLogado: ${estaLogado}
    ''';
  }
}
