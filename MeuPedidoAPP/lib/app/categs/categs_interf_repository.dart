abstract class ICategsRepository {
  Future<List<Map<String, dynamic>>> allCategorias();
  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(String docIdCateg);
}