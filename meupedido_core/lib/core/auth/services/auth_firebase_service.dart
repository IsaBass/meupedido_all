import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meupedido_core/core/auth/services/auth_service_interface.dart';
import 'package:meupedido_core/rsp.dart';

class AuthFirebaseService implements IAuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<Rsp> signOut() async {
    try {
      await _auth.signOut();
      return Rsp.ok(null);
    } catch (e) {
      return Rsp.error(e.toString());
    }
  }

  @override
  Future<Rsp> recoveryPass(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return Rsp.ok(null);
    } catch (e) {
      return Rsp.error(e.toString());
    }

    //   onSucces();
    // }).catchError((e) {
    //   onFail();
    // });
  }

  @override
  Future<Rsp<Map<String, dynamic>>> loginEmailSenha({
    @required String email,
    @required String pass,
  }) async {
    try {
      var user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return Rsp.ok({
        'uid': user.user.uid,
        'photoUrl': user.user.photoURL,
        'email': user.user.email,
        'phoneNumber': user.user.phoneNumber,
      });
    } catch (e) {
      return Rsp.error(e.toString());
    }
  }

  @override
  Future<Rsp<Map<String, dynamic>>> createLoginEmailSenha(
      {String email, String pass}) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      return Rsp.ok({
        'uid': user.user.uid,
        'photoUrl': user.user.photoURL,
        'email': user.user.email,
        'phoneNumber': user.user.phoneNumber,
      });
    } catch (e) {
      return Rsp.error(e.toString());
    }
  }

  @override
  Future<Rsp<Map<String, dynamic>>> loadCurrentUser() async {
    User firebasebUser;

    try {
      ////////
      firebasebUser = _auth.currentUser;
      if (firebasebUser != null) {
        return Rsp.ok({
          'uid': firebasebUser.uid,
          'photoUrl': firebasebUser.photoURL,
          'email': firebasebUser.email,
          'phoneNumber': firebasebUser.phoneNumber,
        });
      }
      //////////

      var us = await _getLoginGoogle(logar: false);
      firebasebUser = us['fbUser'];
      if (firebasebUser != null) {
        return Rsp.ok({
          'uid': firebasebUser.uid,
          'photoUrl': firebasebUser.photoURL,
          'email': firebasebUser.email,
          'phoneNumber': firebasebUser.phoneNumber,
        });
      } else {
        return Rsp.empty();
      }
    } catch (e) {
      return Rsp.error(e.toString());
    }
  }

  /// chamado pelo botao de login
  @override
  Future<Rsp<Map<String, dynamic>>> logarGoogle() async {
    Map<String, dynamic> goog;
    try {
      goog = await _getLoginGoogle(logar: true); // forço logar com google
    } catch (e) {
      return Rsp.error(e.toString());
    }

    User firebasebUser = goog['fbUser'];

    if (firebasebUser == null) {
      return Rsp.empty();
    }

    //if chegou aqui é pq logou no google
    return Rsp.ok({
      'uid': firebasebUser.uid,
      'photoUrl': firebasebUser.photoURL,
      'email': firebasebUser.email,
      'phoneNumber': firebasebUser.phoneNumber,
    });
  }

  Future<Map<String, dynamic>> _getLoginGoogle({@required bool logar}) async {
    print(' entrou em save getLoginGoogle');
    var user = await _getContaGoogle(logar: logar);

    if (user != null) {
      var crredentials = await googleSignIn.currentUser.authentication;

      var use = await _auth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: crredentials.idToken,
          accessToken: crredentials.accessToken));

      return {
        "fbUser": use.user,
        "uid": use.user.uid,
        "name": user.displayName,
        "urlImg": user.photoUrl,
        "email": user.email,
        "phoneNumber": use.user.phoneNumber
      };
    } else {
      return {};
    }
  }

  Future<GoogleSignInAccount> _getContaGoogle({bool logar}) async {
    print(' entrou em save getContaGoogle');
    var user = googleSignIn.currentUser;
    //
    if (logar == true) {
      if (user == null || user.id == null) {
        if (user == null || user.id == null) {
          user = await googleSignIn.signInSilently();
        }
        if (user == null || user.id == null) user = await googleSignIn.signIn();
      }
    }
    return user;
  }

  @override
  Future<Rsp<Map<String, dynamic>>> createLoginGoogle(
      GoogleSignInAccount userGoogle) async {
    try {
      var crredentials = await userGoogle.authentication;

      var use = await _auth.signInWithCredential(GoogleAuthProvider.credential(
          idToken: crredentials.idToken,
          accessToken: crredentials.accessToken));
      if (use != null) {
        return Rsp.ok({
          "fbUser": use.user,
          "uid": use.user.uid,
          "name": use.user.displayName,
          "urlImg": use.user.photoURL,
          "email": use.user.email,
          "phoneNumber": use.user.phoneNumber
        });
      } else {
        return Rsp.empty();
      }
    } catch (e) {
      return Rsp.error(e.toString());
    }

    // if (use != null) {
    //   userAtual.firebasebUser = use.user;
    //   userAtual.urlImg = userGoogle.photoUrl;
    //   userAtual.email = userGoogle.email;

    //   // print('UUid = ' + userAtual.firebasebUser.uid);
    //   // print('Userdata nome = ' + userAtual.nome);

    //   await saveUserData();
    //   await loadCurrentUser();
    //   await _repository.registreAcesso(userAtual.firebasebUser.uid);
    //   setEstaLogado();
    //   onSucces();
    //   isLoading = false;
    // } else {
    //   setNaoEstaLogado();
    //   userAtual.clear();
    //   onFail();
    //   isLoading = false;
    // }
  }

  /////////////.  FIM CLASS
}
