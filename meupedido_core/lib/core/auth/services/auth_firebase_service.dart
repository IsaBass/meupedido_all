import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meupedido_core/core/auth/services/auth_service_interface.dart';
import 'package:meupedido_core/rsp.dart';

class AuthFirebaseService implements IAuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<Rsp<Map<String, dynamic>>> loginEmailSenha({
    @required String email,
    @required String pass,
  }) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return Rsp()
        ..resp = RspType.ok
        ..data = {
          'uid': user.user.uid,
          'photoUrl': user.user.photoURL,
          'email': user.user.email,
          'phoneNumber': user.user.phoneNumber,
        };
    } catch (e) {
      return Rsp()
        ..resp = RspType.error
        ..error = e.toString();
    }
  }

  /////////////.  FIM CLASS
}
