import 'package:meupedido_core/meupedido_core.dart';

import 'package:mobx/mobx.dart';

part 'configs_controller.g.dart';

class ConfigsController = _ConfigsBase with _$ConfigsController;

abstract class _ConfigsBase with Store {
  final CNPJSController _cnpjsController;
  final AuthController _authController;

  _ConfigsBase(this._authController, this._cnpjsController);

  @observable
  bool isLoading = false;

  @action
  Future<void> saveUserData() async {
    isLoading = true;
    await _authController.saveUserData();
    isLoading = false;
  }

  @action
  Future adicioneEmpresa(
      String novoCNPJ, onFail(String texto), Function onSucesso) async {
    var existeEmp = _authController.userAtual.empresas.firstWhere(
        (element) => element.cnpjM.docId == novoCNPJ,
        orElse: () => null);

    if (existeEmp != null) {
      onFail('CNPJ já cadastrado');
      return;
    }

    isLoading = true;
    String desc = await _cnpjsController.getDescricaoCnpj(novoCNPJ);

    if (desc == '') {
      isLoading = false;
      onFail('CNPJ não encontrado');
      return;
    }
    ////
    CnpjModel pj = await _cnpjsController.getCnpjM(novoCNPJ);
    ////
    _authController.addEmpresa(cnpjM: pj);

    ///
    if (_authController.userAtual.cnpjPadrao?.isEmpty ?? true)
      _authController.userAtual.cnpjPadrao = novoCNPJ;
    if (_cnpjsController.cnpjAtivo == null) _cnpjsController.cnpjAtivo = pj;

    _authController.userAtual.empresas = _authController.userAtual.empresas;
    _authController.saveUserData();

    isLoading = false;
    onSucesso();
  }

  @action
  Future tornarEmpresaPadrao(String cnpj) async {
    isLoading = true;

    await _authController.tornarEmpresaPadrao(cnpj);

    isLoading = false;
  }

  @action
  Future<void> excluiEmpresa(UserEmpresa e) async {
    isLoading = true;
    //
    _authController.userAtual.empresas.removeWhere((element) => element == e);
    _authController.userAtual.empresas = _authController.userAtual.empresas;
    await saveUserData();
    //
    isLoading = false;
  }
}
