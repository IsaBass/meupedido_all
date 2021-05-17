abstract class IAlteraAdicRepository {
  Future<String> saveGrupoCateg(Map<String, dynamic> mGrupo, String idCateg);
  Future<String> novoGrupoCateg(Map<String, dynamic> mGrupo, String idCateg);
  Future<String> saveGrupoProd(Map<String, dynamic> mGrupo, String idProduto);
  Future<String> novoGrupoProd(Map<String, dynamic> mGrupo, String idProduto);
}
