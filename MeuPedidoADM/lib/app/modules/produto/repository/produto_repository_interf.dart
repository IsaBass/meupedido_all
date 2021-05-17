abstract class IProdutoRepository {
  ///
  Future updateProd(Map prod);
  Future<String> novoProd(Map prod);
  //
  Future<List<Map<String, dynamic>>> getOpcionais(
      String prodId, String idCateg);
  //
}
