import 'package:flutter/foundation.dart';

abstract class IAuthRepository {
  ///
  Future<Map<String, dynamic>> getUser(String uid);
  Future<void> saveUserData(String uid, Map<String, dynamic> userData);
  Future<void> saveFavoritos(
      {@required String userId,
      @required List<String> favoritos,
      @required String cnpj});
  Future<void> registreAcesso(String uid, {String descricao = 'acesso'});
  Future<void> saveEmpresaPadrao(String uid, String cnpj);
  Future<Map<String, dynamic>> fetchCnpj(String cnpj);

  ///
}
