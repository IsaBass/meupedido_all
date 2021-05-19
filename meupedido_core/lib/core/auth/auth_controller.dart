//import 'package:MeuPedido/app/auth/auth.google_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meupedido_core/core/auth/services/auth_service_interface.dart';

import 'package:meupedido_core/core/fcm/fcm_firebase.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:meupedido_core/rsp.dart';
import 'package:mobx/mobx.dart';

import 'repositories/auth_repository_interf.dart';
import 'user_model.dart';

part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _repository;
  // final CNPJSController _cnpjsController;

  // final CartController _cartController;

  final IAuthService _service;

  // @observable
  // UserModel userAtual;
  @observable
  ObservableList<String> favoritos;

  _AuthControllerBase(this._repository, this._service
      //, this._cnpjsController
      ) {
    // userAtual = UserModel();
    // userAtual.clear();
    favoritos = <String>[].asObservable();
  }

  @observable
  bool isLoading = false;
  @observable
  bool estaLogado = false;

  @action
  void setLoading() => isLoading = true;
  @action
  void setNoLoading() => isLoading = false;

  @action
  void setEstaLogado() => estaLogado = true;
  @action
  void setNaoEstaLogado() => estaLogado = false;

  @action
  Future<void> changeFavorito(String idProduto, String cnpj) async {
    //
    isFavorito(idProduto)
        ? userAtual.favoritos.remove(idProduto)
        : userAtual.favoritos.add(idProduto);
    //

    await _repository.saveFavoritos(
        userId: userAtual.uid, favoritos: userAtual.favoritos, cnpj: cnpj);
    favoritos = userAtual.favoritos.asObservable();
  }

  bool isFavorito(String idProd) => favoritos.contains(idProd);

  Future<UserModel> preencheUserModel(String uid, String cnpj) async {
    ////
    var docUser = await _repository.getUser(uid);
    ////
    ///
    if (docUser != null) {
      // setEstaLogado();

      var user = UserModel();
      // carrega varias inform da base para a variavel userAtual
      user.carregaDoMap(docUser, cnpj);
      // favoritos = userAtual.favoritos.asObservable();

      user.empresas = [];
      for (Map<String, dynamic> emp in docUser["empresas"]) {
        var pj = await _getCnpjM(emp['cnpj']);
        user.addEmpresa(cnpjM: pj, status: emp['status']);
      }

      if (user.tokenCelular == null || user.tokenCelular.isEmpty) {
        await saveUserData();
      }
    }
  }

  Future<CnpjModel> _getCnpjM(String cnpj, {bool carregaFiliais = true}) async {
    //
    if (cnpj.isEmpty) return null;
    //
    var doc = await _repository.fetchCnpj(cnpj);
    //
    if (doc == null) return null;
    //
    return CnpjModel.fromJson(doc);
    //

    // cnpjModel.dadosFiliais = [];
    // if (carregaFiliais == true) {
    //   ///
    //   await refreshFiliais(cnpjModel);
    //   //
    // }

    // return cnpjModel;
  }

  @action
  Future<Rsp<UserModel>> loginEmailSenha({
    @required String email,
    @required String pass,
    @required String cnpj,
  }) async {
    isLoading = false;

    try {
      ///
      var rsp = await _service.loginEmailSenha(email: email, pass: pass);

      ///
      if (rsp.resp == RspType.ok) {
        var user = await preencheUserModel(rsp.data['uid'], cnpj);
        //
        await _repository.registreAcesso(user.uid);
        //

        return Rsp()
          ..resp = RspType.ok
          ..data = user;
      } else {
        return Rsp()
          ..resp = RspType.error
          ..error = rsp.error;
      }
    } catch (e) {
      return Rsp()
        ..resp = RspType.error
        ..error = e.toString();
    }
  }

  @action
  void createLoginEmailSenha(
      {@required String pass,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    isLoading = true;

    _auth
        .createUserWithEmailAndPassword(email: userAtual.email, password: pass)
        .then((user) async {
      userAtual.firebasebUser = user.user;
      userAtual.urlImg = userAtual.firebasebUser.photoURL;

      // print('UUid = ' + userAtual.firebasebUser.uid);
      // print('Userdata nome = ' + userAtual.nome);

      await saveUserData();
      await loadCurrentUser();
      await _repository.registreAcesso(userAtual.firebasebUser.uid);

      setEstaLogado();
      onSucces();
      isLoading = false;
    }).catchError((e) {
      setNaoEstaLogado();
      userAtual.clear();
      onFail();
      isLoading = false;
    });
  }

  @action //// traz info da tabela user e carrega na variavel global userAtual
  Future<UserModel> loadCurrentUser() async {
    print('entrou em loadCurrentUser');
    isLoading = true;

    if (userAtual.firebasebUser == null) {
      userAtual.firebasebUser = _auth.currentUser;
    }
    if (userAtual.firebasebUser == null) await getLoginGoogle(logar: false);
    if (userAtual.firebasebUser != null) {
      ////
      var docUser = await _repository.getUser(userAtual.firebasebUser.uid);
      ////
      ///
      if (docUser != null) {
        setEstaLogado();

        // carrega varias inform da base para a variavel userAtual
        userAtual.carregaDoMap(docUser);
        favoritos = userAtual.favoritos.asObservable();

        userAtual.empresas = [];
        for (Map<String, dynamic> emp in docUser["empresas"]) {
          var pj = await _cnpjsController.getCnpjM(emp['cnpj']);
          userAtual.addEmpresa(cnpjM: pj, status: emp['status']);
          // if (emp['cnpj'] == userAtual.cnpjPadrao) setCnpjAtivo(pj);
        }

        if (userAtual.tokenCelular == null || userAtual.tokenCelular.isEmpty) {
          await saveUserData();
        }

        isLoading = false;
      }

      ///GetIt.I<CarrinhoMobx>().loadCurrentCart(GetIt.I<UserMobx>());
      //}
    }
    isLoading = false;
  }

  @action
  Future<void> recarregaUserEmpresas() async {
    isLoading = true;
    ////
    var docUser = await _repository.getUser(userAtual.firebasebUser.uid);

    ///
    if (docUser != null) {
      // carrega varias inform da base para a variavel userAtual
      userAtual.carregaDoMap(docUser);

      userAtual.empresas = [];
      for (Map emp in docUser["empresas"]) {
        var pj = await _cnpjsController.getCnpjM(emp['cnpj']);

        userAtual.addEmpresa(cnpjM: pj, status: emp['status']);

        // if(pj.docId == userAtual.cnpjAtivo.docId)
        // userAtual.cnpjAtivo = pj;
      }
      userAtual = userAtual;
    }
    isLoading = false;
  }

  // @action
  // void setCnpjAtivo(CnpjModel novoCnpj) {
  //   userAtual.cnpjAtivo = novoCnpj;
  //   userAtual = userAtual;
  //   //_cnpjsController.getEmpresa(novoCnpj);
  // }

  @action
  Future tornarEmpresaPadrao(String cnpj) async {
    userAtual.cnpjPadrao = cnpj;
    userAtual = userAtual;
    await _repository.saveEmpresaPadrao(userAtual.firebasebUser.uid, cnpj);
  }

  Future<void> saveUserData({bool alterarLoading = false}) async {
    print(' entrou em save UserData');
    if (userAtual == null) return;

    if (alterarLoading) isLoading = true;

    Map<String, dynamic> userData = {};

    userData = userAtual.toMap();
    if (userAtual.tokenCelular == null || userAtual.tokenCelular.isEmpty) {
      try {
        userAtual.tokenCelular = await Modular.get<FCMFirebase>().getToken();
        userData['tokenCelular'] = userAtual.tokenCelular;
      } catch (_) {}
    }

    await _repository.saveUserData(userAtual.firebasebUser.uid, userData);
    userAtual = userAtual;
    if (alterarLoading) isLoading = false;
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    await _auth.signOut();
    setNaoEstaLogado();
    userAtual.firebasebUser = null;
    userAtual.clear();
    userAtual = userAtual;
    //GetIt.I<CarrinhoMobx>().limpar();

    isLoading = false;
  }

  @action
  void recoveryPass(
      {String email,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) {
    isLoading = true;
    _auth.sendPasswordResetEmail(email: email).then((value) {
      onSucces();
    }).catchError((e) {
      onFail();
    });
    isLoading = false;
  }

// >>>>>  INICIO FUNCOES GOOGLE  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  @action
  Future<void> createLoginGoogle(
      {@required GoogleSignInAccount userGoogle,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    print('entrou em creteLoginGoogle');
    isLoading = true;

    var crredentials = await userGoogle.authentication;

    var use = await _auth.signInWithCredential(GoogleAuthProvider.credential(
        idToken: crredentials.idToken, accessToken: crredentials.accessToken));

    if (use != null) {
      userAtual.firebasebUser = use.user;
      userAtual.urlImg = userGoogle.photoUrl;
      userAtual.email = userGoogle.email;

      // print('UUid = ' + userAtual.firebasebUser.uid);
      // print('Userdata nome = ' + userAtual.nome);

      await saveUserData();
      await loadCurrentUser();
      await _repository.registreAcesso(userAtual.firebasebUser.uid);
      setEstaLogado();
      onSucces();
      isLoading = false;
    } else {
      setNaoEstaLogado();
      userAtual.clear();
      onFail();
      isLoading = false;
    }
  }

  Future<GoogleSignInAccount> getContaGoogle({bool logar}) async {
    print(' entrou em save getContaGoogle');
    var user = googleSignIn.currentUser;
    //
    if (logar == true) {
      if (user == null || user.id == null) {
        if (user == null || user.id == null) {
          user = await googleSignIn.signInSilently();
        }
        if (user == null || user.id == null) user = await googleSignIn.signIn();
      }
    }
    return user;
  }

  @action
  Future getLoginGoogle({@required bool logar}) async {
    print(' entrou em save getLoginGoogle');
    var user = await getContaGoogle(logar: logar);

    if (user != null) {
      var crredentials = await googleSignIn.currentUser.authentication;

      var use = await _auth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: crredentials.idToken,
          accessToken: crredentials.accessToken));

      userAtual.nome = user.displayName;
      userAtual.urlImg = user.photoUrl;
      userAtual.email = user.email;
      userAtual.firebasebUser = use.user;
    }
  }

  @action
  Future<String> logarGoogle(
      //chamado pelo botao de login
      {@required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    print(' entrou em save logarGoogle');
    isLoading = true;

    await getLoginGoogle(logar: true); // forço logar com google

    if (userAtual.firebasebUser == null) {
      // if nao logou entao dou fail e saio
      setNaoEstaLogado();
      isLoading = false;
      onFail();
      return 'naologado';
    }

    //if chegou aqui é pq logou no google
    // vou verificar se ja tem cadastro na base de dados
    var docUser = await _repository.getUser(userAtual.firebasebUser.uid);

    if (docUser != null) {
      //ja tem cadastro no user da base

      await loadCurrentUser();
      await _repository.registreAcesso(userAtual.firebasebUser.uid);

      setEstaLogado();
      onSucces();
      isLoading = false;
      return 'OK';
    }
    setNaoEstaLogado();
    isLoading = false;
    return 'NOVO';
  }
}
