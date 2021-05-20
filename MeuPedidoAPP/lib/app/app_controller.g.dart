// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppController on _AppControllerBase, Store {
  Computed<bool> _$estaLogadoComputed;

  @override
  bool get estaLogado =>
      (_$estaLogadoComputed ??= Computed<bool>(() => super.estaLogado,
              name: '_AppControllerBase.estaLogado'))
          .value;
  Computed<List<String>> _$getFavoritosComputed;

  @override
  List<String> get getFavoritos => (_$getFavoritosComputed ??=
          Computed<List<String>>(() => super.getFavoritos,
              name: '_AppControllerBase.getFavoritos'))
      .value;

  final _$cnpjAtivoAtom = Atom(name: '_AppControllerBase.cnpjAtivo');

  @override
  CnpjModel get cnpjAtivo {
    _$cnpjAtivoAtom.reportRead();
    return super.cnpjAtivo;
  }

  @override
  set cnpjAtivo(CnpjModel value) {
    _$cnpjAtivoAtom.reportWrite(value, super.cnpjAtivo, () {
      super.cnpjAtivo = value;
    });
  }

  final _$userAtualAtom = Atom(name: '_AppControllerBase.userAtual');

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

  final _$isLoadingAtom = Atom(name: '_AppControllerBase.isLoading');

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

  final _$saveUserDataAsyncAction =
      AsyncAction('_AppControllerBase.saveUserData');

  @override
  Future<void> saveUserData({bool alterarLoading = false}) {
    return _$saveUserDataAsyncAction
        .run(() => super.saveUserData(alterarLoading: alterarLoading));
  }

  final _$loadCurrentUserAsyncAction =
      AsyncAction('_AppControllerBase.loadCurrentUser');

  @override
  Future<bool> loadCurrentUser() {
    return _$loadCurrentUserAsyncAction.run(() => super.loadCurrentUser());
  }

  final _$loginEmailSenhaAsyncAction =
      AsyncAction('_AppControllerBase.loginEmailSenha');

  @override
  Future<bool> loginEmailSenha(
      {String email, String pass, VoidCallback onSucces, VoidCallback onFail}) {
    return _$loginEmailSenhaAsyncAction.run(() => super.loginEmailSenha(
        email: email, pass: pass, onSucces: onSucces, onFail: onFail));
  }

  final _$logarGoogleAsyncAction =
      AsyncAction('_AppControllerBase.logarGoogle');

  @override
  Future<String> logarGoogle({VoidCallback onSucces, VoidCallback onFail}) {
    return _$logarGoogleAsyncAction
        .run(() => super.logarGoogle(onSucces: onSucces, onFail: onFail));
  }

  final _$signOutAsyncAction = AsyncAction('_AppControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$changeFavoritoAsyncAction =
      AsyncAction('_AppControllerBase.changeFavorito');

  @override
  Future<void> changeFavorito(String idProduto) {
    return _$changeFavoritoAsyncAction
        .run(() => super.changeFavorito(idProduto));
  }

  final _$_AppControllerBaseActionController =
      ActionController(name: '_AppControllerBase');

  @override
  void _setUsuarioLogado(UserModel user) {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase._setUsuarioLogado');
    try {
      return super._setUsuarioLogado(user);
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void _limpaIsuarioLogado() {
    final _$actionInfo = _$_AppControllerBaseActionController.startAction(
        name: '_AppControllerBase._limpaIsuarioLogado');
    try {
      return super._limpaIsuarioLogado();
    } finally {
      _$_AppControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cnpjAtivo: ${cnpjAtivo},
userAtual: ${userAtual},
isLoading: ${isLoading},
estaLogado: ${estaLogado},
getFavoritos: ${getFavoritos}
    ''';
  }
}
