abstract class ListEnderecosRepositoryI {
  Future<List<Map>> getEnderecos();
  Future<void> excluiEndereco(String idEnd);
}