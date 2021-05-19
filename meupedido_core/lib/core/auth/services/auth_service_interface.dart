import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meupedido_core/rsp.dart';

abstract class IAuthService {
  //
  Future<Rsp> signOut();
  Future<Rsp> recoveryPass(String email);
  //
  Future<Rsp<Map<String, dynamic>>> loginEmailSenha({
    @required String email,
    @required String pass,
  });
  //
  Future<Rsp<Map<String, dynamic>>> createLoginEmailSenha({
    @required String email,
    @required String pass,
  });
  //
  Future<Rsp<Map<String, dynamic>>> loadCurrentUser();
  //
  /// chamado pelo botao de login
  ///  aqui outra orientação
  Future<Rsp<Map<String, dynamic>>> logarGoogle();
  //
  Future<Rsp<Map<String, dynamic>>> createLoginGoogle(
      GoogleSignInAccount userGoogle);
  //
}
