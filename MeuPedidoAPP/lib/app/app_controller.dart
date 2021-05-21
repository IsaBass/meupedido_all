import 'package:MeuPedido/app/app_repository_interf.dart';
import 'package:flutter/foundation.dart';

import 'package:meupedido_core/rsp.dart';
import 'package:mobx/mobx.dart';
import 'package:meupedido_core/meupedido_core.dart';

part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final AuthController _authController;
  final CNPJSController _cnpjsController;
  final CartController _cartController;
  final IAppRepository _appRepository;

  _AppControllerBase(this._authController, this._cnpjsController,
      this._appRepository, this._cartController);

  @observable
  CnpjModel cnpjAtivo;
  @observable
  UserModel userAtual = UserModel();
  @observable
  bool isLoading = false;

  @computed
  bool get estaLogado => (userAtual?.uid ?? "") != "";

  ////
  // DocumentReference get userAtualDocRef => _authController.userAtual.docRef;
  // DocumentReference get cnpjAtivoDocRef =>
  //     FirebaseFirestore.instance.collection("CNPJS").doc(cnpjAtivo.docId);
  String get userAtualDocId => userAtual.uid;
  String get cnpjAtivoDocId => cnpjAtivo.docId; // docId é o CNPJ
  ////

  @action
  Future<void> saveUserData({bool alterarLoading = false}) async {
    isLoading = true;

    await _authController.saveUserData(userAtual, cnpjAtivo.docId);

    isLoading = false;
  }

  Future<bool> setCnpjAtivo(String cnpj) async {
    //
    var rsp = await _cnpjsController.getCnpjM(cnpj);
    //
    if (rsp.resp == RspType.ok) {
      cnpjAtivo = rsp.data;
      return true;
    } else {
      cnpjAtivo.docId = "";
      return false;
    }
  }

  Future<bool> setCnpjAtivoByIdent(String identificador) async {
    //
    var rsp = await _cnpjsController.getCnpjMIdentificador(identificador);
    //
    if (rsp.resp == RspType.ok) {
      cnpjAtivo = rsp.data;
      return true;
    } else {
      cnpjAtivo.docId = "";
      return false;
    }
  }

  Future<bool> carregaEmpresaAtiva(String identificador) async {
    if (kIsWeb) {
      if (identificador == null || identificador == '') {
        print("SPLASH: Na WEB E SEM IDENTIFICADOR!!! ");
        return false;
      } else {
        var resp = await setCnpjAtivoByIdent(identificador);
        if (resp == false) {
          print("Empresa Não encontrada by Identif ${identificador}");
          // direcionar pra pag de erro...empresa nao encontrada
          return false;
        }
      }
      return true;
    } else {
      //..em app mobile..sempre tem empresafixa
      var resp = await setCnpjAtivo(MyConst.cnpjEmpresaFixa);
      if (resp == false) {
        print(
            "splash Empresa Não encontrada by CNPJ ${MyConst.cnpjEmpresaFixa}");
        // direcionar pra pag de erro...empresa nao encontrada
        return false;
      }
      print(
        'na tela splach:: empresa ativa = ${cnpjAtivo.descricao}',
      );
      return true;
    }
  }

  // SEÇÃO LOGAR ////////////////////////////////////////

  @action
  void _setUsuarioLogado(UserModel user) {
    //
    userAtual = user;
    //
    _cartController.setVariables(userAtual.uid, cnpjAtivo.docId);
    _cartController.carregaCarrinhoUser();
    //
  }

  @action
  void _limpaIsuarioLogado() {
    //
    _cartController.limparCarrinho();
    _cartController.clearVariables();
    //
    userAtual.clear();
    userAtual = userAtual;
    //
  }

  @action
  Future<bool> loadCurrentUser() async {
    isLoading = true;
    //
    var rsp = await _authController.loadCurrentUser(cnpjAtivo.docId);

    if (rsp.resp == RspType.ok) {
      //
      _setUsuarioLogado(rsp.data);
      //
      isLoading = false;
      return true;
    } else {
      //
      _limpaIsuarioLogado();
      //
      isLoading = false;
      return false;
    }

    //
    // isLoading = false;
  }

  @action
  Future<bool> loginEmailSenha({
    @required String email,
    @required String pass,
    @required VoidCallback onSucces,
    @required VoidCallback onFail,
  }) async {
    isLoading = true;

    ///
    var rsp = await _authController.loginEmailSenha(
      email: email,
      pass: pass,
      cnpj: cnpjAtivo.docId,
    );

    ////////
    if (rsp.resp == RspType.ok) {
      //
      _setUsuarioLogado(rsp.data);
      //
      isLoading = false;
      onSucces();
      return true;
    } else {
      isLoading = false;
      onFail();
      return false;
    }
    ////////
  }

  @action
  Future<String> logarGoogle(
      //chamado pelo botao de login
      {@required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    print(' entrou em save logarGoogle');
    // isLoading = true;

    var rsp = await _authController.logarGoogle(cnpj: cnpjAtivo.docId);

    /////////////
    if (rsp.resp == RspType.ok) {
      //
      _setUsuarioLogado(rsp.data);
      //
      isLoading = false;
      onSucces();
      return "OK";
    } else if (rsp.resp == RspType.error && rsp.error == "NOVO") {
      isLoading = false;
      return "NOVO";
    } else {
      isLoading = false;
      onFail();
      return "erro";
    }
    /////////////
  }

  @action
  Future<void> createLoginEmailSenha(
      {@required String email,
      @required String pass,
      @required String nome,
      @required VoidCallback onSucces,
      @required VoidCallback onFail}) async {
    isLoading = true;

    var rsp = await _authController.createLoginEmailSenha(
      email: email,
      pass: pass,
      cnpj: cnpjAtivo.docId,
    );

    if (rsp.resp == RspType.ok) {
      var user = rsp.data
        ..nome = nome
        ..email = email;

      _setUsuarioLogado(user);

      await saveUserData();

      isLoading = false;
      onSucces();
    } else {
      _limpaIsuarioLogado();
      isLoading = false;
      onFail();
    }
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    var rsp = await _authController.signOut();

    if (rsp.resp == RspType.error) {
      // mensagem que nao conseguiu deslogar
      isLoading = false;
      return;
    }
    //
    _limpaIsuarioLogado();

    isLoading = false;
  }

  // SEÇÃO FAVORITOS ////////////////////////////////////////
  @action
  Future<void> changeFavorito(String idProduto) async {
    isLoading = true;
    await _authController.changeFavorito(userAtual, idProduto, cnpjAtivo.docId);
    isLoading = false;
  }

  @computed
  List<String> get getFavoritos => _authController.favoritos;

  // @computed
  bool isFavorito(String idProd) => _authController.isFavorito(idProd);
  //
  ////////////////////////////////////////////////////////

  //
  Future<CnpjConfigsModel> getCnpjConfigs() async {
    //
    var map = await _appRepository.getCnpjConfigs(cnpjAtivo.docId);

    return CnpjConfigsModel.fromJson(map);
    //
  }
}
