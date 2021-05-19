import 'cnpj_model.dart';
import 'repositories/cnpj_repository_interf.dart';

class CNPJSController {
  final ICnpjRepository _cnpjRepository;

  CNPJSController(this._cnpjRepository);

  // CnpjModel cnpjAtivo;

  Future<CnpjModel> getCnpjM(String cnpj, {bool carregaFiliais = true}) async {
    //
    if (cnpj.isEmpty) return null;
    //
    var doc = await _cnpjRepository.fetchCnpj(cnpj);
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

  Future<CnpjModel> getCnpjMIdentificador(String identificador,
      {bool carregaFiliais = true}) async {
    //
    if (identificador.isEmpty) return null;
    //
    var doc = await _cnpjRepository.fetchIdentificador(identificador);
    //
    if (doc == null) return null;
    //

    return CnpjModel.fromJson(doc);
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
