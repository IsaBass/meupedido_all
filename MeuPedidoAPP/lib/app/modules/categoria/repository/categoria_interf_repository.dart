abstract class ICategoriaRepository {
  //
  Future<List<Map>> prodsCategoria(int codCateg);
  //
  Future<List<Map>> getProdsDestaqueGeral();
  Future<List<Map>> getProdsTodosDestaque();
}
