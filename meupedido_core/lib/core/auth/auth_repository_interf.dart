abstract class IAuthRepository {
  ///
  Future<Map<String, dynamic>> getUser(String uid);
  Future<void> saveUserData(String uid, Map<String, dynamic> userData);
  Future<void> saveFavoritos(String userId, List<String> favoritos);
  Future<void> registreAcesso(String uid, {String descricao = 'acesso'});
  Future<void> saveEmpresaPadrao(String uid, String cnpj);

  ///
}
