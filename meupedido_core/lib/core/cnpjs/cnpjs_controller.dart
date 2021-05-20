import 'package:meupedido_core/rsp.dart';

import 'cnpj_model.dart';
import 'repositories/cnpj_repository_interf.dart';

class CNPJSController {
  final ICnpjRepository _cnpjRepository;

  CNPJSController(this._cnpjRepository);

  // CnpjModel cnpjAtivo;

  Future<Rsp<CnpjModel>> getCnpjM(String cnpj,
      {bool carregaFiliais = true}) async {
    //
    if (cnpj.isEmpty) return Rsp.empty();
    //
    Map<String, dynamic> doc = {};
    try {
      doc = await _cnpjRepository.fetchCnpj(cnpj);
    } catch (e) {
      Rsp.error(e.toString());
    }
    //
    if (doc == null || doc == {}) return Rsp.empty();
    //
    return Rsp.ok(CnpjModel.fromJson(doc));
    //

    // cnpjModel.dadosFiliais = [];
    // if (carregaFiliais == true) {
    //   ///
    //   await refreshFiliais(cnpjModel);
    //   //
    // }

    // return cnpjModel;
  }

  Future<Rsp<CnpjModel>> getCnpjMIdentificador(String identificador,
      {bool carregaFiliais = true}) async {
    //
    if (identificador.isEmpty) return Rsp.empty();
    //
    Map<String, dynamic> doc = {};
    try {
      doc = await _cnpjRepository.fetchIdentificador(identificador);
    } catch (e) {
      Rsp.error(e.toString());
    }
    //
    if (doc == null || doc == {}) return Rsp.empty();
    //

    return Rsp.ok(CnpjModel.fromJson(doc));
  }

  Future<String> getDescricaoCnpj(String cnpj) async {
    return await _cnpjRepository.descricaoCnpj(cnpj);
  }

  // Future refreshFiliais(CnpjModel emp) async {
  //   emp.dadosFiliais = [];

  //   QuerySnapshot queryFilial = await _cnpjRepository.getFiliais(emp.docId);

  //   return emp.dadosFiliais.addAll(queryFilial.documents
  //       .map((docFilial) => Filial.fromJson(docFilial.data))
  //       .toList());
  // }
}
