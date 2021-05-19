import 'package:flutter/foundation.dart';
import 'package:meupedido_core/rsp.dart';

abstract class IAuthService {
  //
  Future<Rsp<Map<String, dynamic>>> loginEmailSenha({
    @required String email,
    @required String pass,
  });
  //

}
