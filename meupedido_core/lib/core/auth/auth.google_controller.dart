// import 'package:estoquecentral/app/auth/auth_controller.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:mobx/mobx.dart';

// import '../app_module.dart';
// import 'auth_repository.dart';


class AuthGoogleController   {
  
  // final googleSignIn = GoogleSignIn();
  // FirebaseAuth _auth = FirebaseAuth.instance;

  // final AuthRepository repository = AppModule.to.get<AuthRepository>();
  // //final CnpjRepository cnpjRepository;
  
  // final AuthController _authController = AppModule.to.get<AuthController>();
   
    
  // @action
  // Future<void> createLoginGoogle(
  //     {@required GoogleSignInAccount userGoogle,
  //     @required VoidCallback onSucces,
  //     @required VoidCallback onFail}) async {

  //   // _authController.isLoading = true;
  //   _authController.setLoading(true);

  //   GoogleSignInAuthentication crredentials = await userGoogle.authentication;

  //   var use = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
  //       idToken: crredentials.idToken, accessToken: crredentials.accessToken));

  //   if (use != null) {
  //     _authController.setFirebaseUser(use.user);
  //     // _authController.userAtual.firebasebUser = use.user;
  //     _authController.setUrlImg(userGoogle.photoUrl);
  //     _authController.setEmail(userGoogle.email);

  //     print('UUid = ' + _authController.userAtual.firebasebUser.uid);
  //     print('Userdata nome = ' + _authController.userAtual.nome);

  //     await _authController.saveUserData();
  //     await _authController.loadCurrentUser();
  //     await repository.registreAcesso(_authController.userAtual.firebasebUser.uid);

  //     onSucces();
  //    _authController.setLoading(false);
  //   } else {
  //     _authController.userAtual.clear();
  //     onFail();
  //     _authController.setLoading(false);
  //   }
  // }

  // Future<GoogleSignInAccount> getContaGoogle({bool logar}) async {
  //   GoogleSignInAccount user = googleSignIn.currentUser;
  //   //
  //   if (logar == true) {
  //     if (user == null) {
  //       if (user == null) user = await googleSignIn.signInSilently();
  //       if (user == null) user = await googleSignIn.signIn();
  //     }
  //   }
  //   return user;
  // }

  // @action
  // Future getLoginGoogle({@required bool logar}) async {
  //   var user = await getContaGoogle(logar: logar);

  //   if (user != null) {
  //     GoogleSignInAuthentication crredentials =
  //         await googleSignIn.currentUser.authentication;

  //     var use = await _auth.signInWithCredential(
  //         GoogleAuthProvider.getCredential(
  //             idToken: crredentials.idToken,
  //             accessToken: crredentials.accessToken));

  //     _authController.setNome(user.displayName);
  //     _authController.setUrlImg(user.photoUrl);
  //     _authController.setEmail(user.email);
  //     _authController.setFirebaseUser(use.user);
  //   }
  // }

  // @action
  // Future<String> logarGoogle(
  //     //chamado pelo botao de login
  //     {@required VoidCallback onSucces,
  //     @required VoidCallback onFail}) async {
  //   _authController.setLoading(true);

  //   await getLoginGoogle(logar: true); // forço logar com google

  //   if (_authController.userAtual.firebasebUser == null) {
  //     // if nao logou entao dou fail e saio
  //     _authController.setEstaLogado(false);
  //     _authController.setLoading(false);
  //     onFail();
  //     return 'naologado';
  //   }

  //   //if chegou aqui é pq logou no google
  //   // vou verificar se ja tem cadastro na base de dados
  //   var docUser = await repository.getUser(_authController.userAtual.firebasebUser.uid);

  //   if (docUser != null ) {
  //     //ja tem cadastro no user da base

  //     await _authController.loadCurrentUser();
  //     await repository.registreAcesso(_authController.userAtual.firebasebUser.uid);

  //     _authController.setEstaLogado(true);
  //     onSucces();
  //     _authController.setLoading(false);
  //     return 'OK';
  //   }

  //   _authController.setLoading(false);
  //   return 'NOVO';
  // }

  
}