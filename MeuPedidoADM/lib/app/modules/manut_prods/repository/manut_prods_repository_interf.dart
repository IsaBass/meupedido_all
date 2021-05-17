abstract class IManutProdsRepository {
  //
  Future<List<Map<String, dynamic>>> allCategorias();
  Future<List<Map<String, dynamic>>> getProdsCateg(int codCateg);
  //
}
