//import 'package:MeuPedido/app/auth/auth.google_controller.dart';

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
  Future<void> changeFavorito(
      UserModel user, String idProduto, String cnpj) async {
    //
    isFavorito(idProduto)
        ? user.favoritos.remove(idProduto)
        : user.favoritos.add(idProduto);
    //

    await _repository.saveFavoritos(
        userId: user.uid, favoritos: user.favoritos, cnpj: cnpj);
    favoritos = user.favoritos.asObservable();
  }

  bool isFavorito(String idProd) => favoritos.contains(idProd);

  Future<UserModel> preencheUserModel(String uid, String cnpj) async {
    var user = UserModel();
    ////
    var docUser = await _repository.getUser(uid);
    ////
    ///
    if (docUser != null) {
      // setEstaLogado();

      // carrega varias inform da base para a variavel userAtual
      user.carregaDoMap(docUser, cnpj);
      // favoritos = userAtual.favoritos.asObservable();

      user.empresas = [];
      for (Map<String, dynamic> emp in docUser["empresas"]) {
        var pj = await _getCnpjM(emp['cnpj']);
        user.addEmpresa(cnpjM: pj, status: emp['status']);
      }

      if (user.tokenCelular == null || user.tokenCelular.isEmpty) {
        await saveUserData(user, cnpj);
      }
    }
    return user;
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

        return Rsp.ok(user);
      } else {
        return Rsp.error(rsp.error);
      }
    } catch (e) {
      return Rsp.error(e.toString());
    }
  }

  @action
  Future<Rsp<UserModel>> createLoginEmailSenha(
      {@required String email,
      @required String pass,
      @required String cnpj,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    isLoading = true;

    var rsp = await _service.createLoginEmailSenha(email: email, pass: pass);

    if (rsp.resp == RspType.ok) {
      var user = await preencheUserModel(rsp.data['uid'], cnpj);
      user.urlImg = rsp.data['photoURL'];

      await saveUserData(user, cnpj);
      await _repository.registreAcesso(user.uid);

      onSucces();

      return Rsp.ok(user);
    } else {
      return Rsp.error(rsp.error);
    }

    // _auth
    //     .createUserWithEmailAndPassword(email: email, password: pass)
    //     .then((user) async {
    //   userAtual.firebasebUser = user.user;
    //   userAtual.urlImg = userAtual.firebasebUser.photoURL;

    //   // print('UUid = ' + userAtual.firebasebUser.uid);
    //   // print('Userdata nome = ' + userAtual.nome);

    //   await saveUserData();
    //   await loadCurrentUser();
    //   await _repository.registreAcesso(userAtual.firebasebUser.uid);

    //   setEstaLogado();
    //   onSucces();
    //   isLoading = false;
    // }).catchError((e) {
    //   setNaoEstaLogado();
    //   userAtual.clear();
    //   onFail();
    //   isLoading = false;
    // });
  }

  @action //// traz info da tabela user e carrega na variavel global userAtual
  Future<Rsp<UserModel>> loadCurrentUser(String cnpj) async {
    print('entrou em loadCurrentUser');
    isLoading = true;

    var rsp = await _service.loadCurrentUser();

    if (rsp.resp == RspType.empty) {
      return Rsp.empty();
    } else if (rsp.resp == RspType.ok) {
      var user = await preencheUserModel(rsp.data['uid'], cnpj);
      await saveUserData(user, cnpj);
      return Rsp.ok(user);
    } else {
      return Rsp.error(rsp.error);
    }

    ///GetIt.I<CarrinhoMobx>().loadCurrentCart(GetIt.I<UserMobx>());
    //}
  }

  @action
  Future<UserModel> recarregaUserEmpresas(String uid, String cnpj) async {
    isLoading = true;
    //
    var u = await preencheUserModel(uid, cnpj);
    //
    isLoading = false;
    return u;
  }

  // @action
  // void setCnpjAtivo(CnpjModel novoCnpj) {
  //   userAtual.cnpjAtivo = novoCnpj;
  //   userAtual = userAtual;
  //   //_cnpjsController.getEmpresa(novoCnpj);
  // }

  @action
  Future tornarEmpresaPadrao(UserModel userAtual, String cnpj) async {
    userAtual.cnpjPadrao = cnpj;
    // userAtual = userAtual;
    await _repository.saveEmpresaPadrao(userAtual.uid, cnpj);
  }

  Future<void> saveUserData(UserModel userAtual, String cnpj,
      {bool alterarLoading = false}) async {
    print(' entrou em save UserData');
    if (userAtual == null) return;

    if (alterarLoading) isLoading = true;

    Map<String, dynamic> userData = {};

    userData = userAtual.toMap(cnpj);
    if (userAtual.tokenCelular == null || userAtual.tokenCelular.isEmpty) {
      try {
        userAtual.tokenCelular = await Modular.get<FCMFirebase>().getToken();
        userData['tokenCelular'] = userAtual.tokenCelular;
      } catch (_) {}
    }

    await _repository.saveUserData(userAtual.uid, userData);
    userAtual = userAtual;
    if (alterarLoading) isLoading = false;
  }

  @action
  Future<Rsp> signOut() async {
    isLoading = true;
    var rsp = await _service.signOut();
    isLoading = false;
    return rsp;

    /*
    setNaoEstaLogado();
    userAtual.firebasebUser = null;
    userAtual.clear();
    userAtual = userAtual;
    //GetIt.I<CarrinhoMobx>().limpar();
*/
  }

  @action
  Future<void> recoveryPass(
      {String email,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    isLoading = true;

    var rsp = await _service.recoveryPass(email);
    //
    if (rsp.resp == RspType.error) {
      onFail();
      return;
    } else {
      onSucces();
    }

    // _auth.sendPasswordResetEmail(email: email).then((value) {
    // }).catchError((e) {
    //   onFail();
    // });

    isLoading = false;
  }

// >>>>>  INICIO FUNCOES GOOGLE  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

  @action
  Future<Rsp<UserModel>> createLoginGoogle(
      {@required GoogleSignInAccount userGoogle,
      @required String cnpj,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    print('entrou em creteLoginGoogle');
    isLoading = true;

    Rsp rsp; // = Rsp.empty();
    Map<String, dynamic> use;

    try {
      rsp = await _service.createLoginGoogle(userGoogle);
      if (rsp.resp == RspType.ok) {
        use = (rsp.data as Map<String, dynamic>);
      }
    } catch (e) {
      return Rsp.error(e);
    }

    if (rsp.resp == RspType.error) return Rsp.error(rsp.error);
    if (rsp.resp == RspType.empty) return Rsp.empty();

    if (use != null) {
      var user = await preencheUserModel(use['uid'], cnpj);
      await saveUserData(user, cnpj);
      return Rsp.ok(user);
    } else {
      return Rsp.empty();
    }

    //   userAtual.firebasebUser = use.user;
    //   userAtual.urlImg = userGoogle.photoUrl;
    //   userAtual.email = userGoogle.email;

    //   // print('UUid = ' + userAtual.firebasebUser.uid);
    //   // print('Userdata nome = ' + userAtual.nome);

    //   await saveUserData();
    //   await loadCurrentUser();
    //   await _repository.registreAcesso(userAtual.firebasebUser.uid);
    //   setEstaLogado();
    //   onSucces();
    //   isLoading = false;
    // } else {
    //   setNaoEstaLogado();
    //   userAtual.clear();
    //   onFail();
    //   isLoading = false;
    // }
  }

  // Future<GoogleSignInAccount> getContaGoogle({bool logar}) async {
  //   print(' entrou em save getContaGoogle');
  //   var user = googleSignIn.currentUser;
  //   //
  //   if (logar == true) {
  //     if (user == null || user.id == null) {
  //       if (user == null || user.id == null) {
  //         user = await googleSignIn.signInSilently();
  //       }
  //       if (user == null || user.id == null) user = await googleSignIn.signIn();
  //     }
  //   }
  //   return user;
  // }

  // @action
  // Future getLoginGoogle({@required bool logar}) async {
  //   print(' entrou em save getLoginGoogle');
  //   var user = await getContaGoogle(logar: logar);

  //   if (user != null) {
  //     var crredentials = await googleSignIn.currentUser.authentication;

  //     var use = await _auth.signInWithCredential(GoogleAuthProvider.credential(
  //         idToken: crredentials.idToken,
  //         accessToken: crredentials.accessToken));

  //     userAtual.nome = user.displayName;
  //     userAtual.urlImg = user.photoUrl;
  //     userAtual.email = user.email;
  //     userAtual.firebasebUser = use.user;
  //   }
  // }

  @action
  Future<Rsp<UserModel>> logarGoogle(
      //chamado pelo botao de login
      {@required String cnpj,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    print(' entrou em save logarGoogle');
    // isLoading = true;

    var rsp = await _service.logarGoogle();

    if (rsp.resp == RspType.error) {
      return Rsp.error(rsp.error);
    }
    if (rsp.resp == RspType.empty) {
      return Rsp.empty();
    }

    var user = await preencheUserModel(rsp.data['uid'], cnpj);

    await saveUserData(user, cnpj);
    await _repository.registreAcesso(user.uid);

    return Rsp.ok(user);

    // if (userAtual.firebasebUser == null) {
    //   // if nao logou entao dou fail e saio
    //   setNaoEstaLogado();
    //   isLoading = false;
    //   onFail();
    //   return 'naologado';
    // }

    // //if chegou aqui é pq logou no google
    // // vou verificar se ja tem cadastro na base de dados
    // var docUser = await _repository.getUser(userAtual.firebasebUser.uid);

    // if (docUser != null) {
    //   //ja tem cadastro no user da base

    //   await loadCurrentUser();
    //   await _repository.registreAcesso(userAtual.firebasebUser.uid);

    //   setEstaLogado();
    //   onSucces();
    //   isLoading = false;
    //   return 'OK';
    // }
    // setNaoEstaLogado();
    // isLoading = false;
    // return 'NOVO';
  }
}
