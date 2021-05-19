abstract class ICategsRepository {
  Future<List<Map<String, dynamic>>> allCategorias(String cnpj);
  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(
      String cnpj, String docIdCateg);
}
