import 'package:MeuPedido/app/app_repository_interf.dart';

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
  UserModel userAtual;
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

  // SEÇÃO LOGAR ////////////////////////////////////////

  @action
  Future<void> loadCurrentUser() async {
    isLoading = true;
    //
    var rsp = await _authController.loadCurrentUser(cnpjAtivo.docId);

    if (rsp.resp == RspType.ok) {
      //
      userAtual = rsp.data;
      //
      _cartController.setVariables(userAtual.uid, cnpjAtivo.docId);
      _cartController.carregaCarrinhoUser();
      //
    } else {
      //
      _cartController.limparCarrinho();
      _cartController.clearVariables();
      //
      userAtual.clear();
      userAtual = userAtual;
    }

    //
    isLoading = false;
  }

  @action
  Future<void> signOut() async {
    isLoading = true;
    var rsp = await _authController.signOut();

    if (rsp.resp == RspType.error) {
      // mensagem que nao conseguiu deslogar
      return;
    }
    //
    _cartController.limparCarrinho();
    _cartController.clearVariables();
    //

    userAtual.clear();
    userAtual = userAtual;

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

  @computed
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
