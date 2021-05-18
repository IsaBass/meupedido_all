import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'repository/endereco_interf_repository.dart';

class EnderecoController extends GetxController {
  final IEnderecoRepository _repository = Modular.get();

  final isLoading = false.obs;

  EnderecoController();

  Future<String> gravaEndereco(EnderecoModel end) async {
    isLoading.value = true;
    var s = await _repository.gravaEndereco(end.toJson());
    isLoading.value = false;
    return s;
  }

  Future<void> excluiEndereco(EnderecoModel end) async {
    isLoading.value = true;
    //
    var id = end.docId;
    await _repository.excluiEndereco(id);
    // enderecos.remove(end);
    //

    isLoading.value = false;
  }

  Future<void> alteraEndereco(EnderecoModel end) async {
    isLoading.value = true;
    //
    await _repository.alteraEndereco(
        id: end.docId,
        complem: end.complemento,
        numero: end.numero,
        coordLat: end.coordLat,
        coordLong: end.coordLong);
    //
    isLoading.value = false;
  }

  Future<Map> buscaCEP(String cep) async {
    isLoading.value = true;
    var ret = await _repository.buscaCEP(cep);
    isLoading.value = false;
    return ret;
  }
}
