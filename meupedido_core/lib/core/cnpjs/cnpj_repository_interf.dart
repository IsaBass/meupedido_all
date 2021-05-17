import 'cnpj_model.dart';

abstract class ICnpjRepository {
  ///
  Future<Map<String, dynamic>> fetchCnpj(String cnpj);
  //
  Future<Map<String, dynamic>> fetchIdentificador(String identificador);
  //
  Future<String> descricaoCnpj(String cnpj);
  //
  Future<List<Map<String, dynamic>>> getAllCnpjs();
  Future saveCNPJ(CnpjModel emp);
  Future saveNovoCNPJ(CnpjModel emp);
  //
}
