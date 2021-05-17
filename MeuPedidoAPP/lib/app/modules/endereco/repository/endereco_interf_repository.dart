abstract class IEnderecoRepository {
  //
  Future<void> alteraEndereco({
    String id,
    String numero,
    String complem,
    double coordLat,
    double coordLong,
  });
  Future<void> excluiEndereco(String id);
  Future<String> gravaEndereco(Map dados);
  //
  Future<Map> buscaCEP(String cep);
  //
}
