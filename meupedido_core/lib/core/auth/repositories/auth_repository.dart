//import 'package:cloud_firestore_all/cloud_firestore_all.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_repository_interf.dart';

class AuthRepository extends Disposable implements IAuthRepository {
  ///
  //final CNPJSController _cnpjsController;

  Future<Map<String, dynamic>> getUser(String uid) async {
    var doc =
        //await firestoreInstance.collection("users").document(uid).get();
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    print(' >> AuthRepos.getUser : $uid ');
    return doc.data()..['docRef'] = doc.reference;
  }

  Future<void> saveUserData(String uid, Map<String, dynamic> userData) async {
    // await firestoreInstance.collection("users").document(uid).set(userData);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(userData, SetOptions(merge: true));
    print(' >> AuthRepos.saveUserData : $uid ');
  }

  Future<void> saveFavoritos(
      {String userId, List<String> favoritos, String cnpj}) async {
    //
    await FirebaseFirestore.instance.collection("users").doc(userId).set(
      {"favoritos$cnpj": favoritos},
      SetOptions(merge: true),
    );
    print(' >> AuthRepos.saveFavoritos : $favoritos ');
  }

  Future<void> saveEmpresaPadrao(String uid, String cnpj) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set({'cnpjPadrao': cnpj}, SetOptions(merge: true));
    print(' >> AuthRepos.saveEmpresaPadrao : $uid  $cnpj ');
  }

  Future<void> registreAcesso(String uid, {String descricao = 'acesso'}) async {
    // await firestoreInstance
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .collection('acessos')
        .add({
      "dataHora": DateTime.now(),
      "descricao": descricao,
      "cordenadaLA": 0,
      "cordenadaLO": 0
    });
    print(' >> AuthRepos.registreAcesso ');
  }

  Future<Map<String, dynamic>> fetchCnpj(String cnpj) async {
    var doc =
        await FirebaseFirestore.instance.collection('CNPJS').doc(cnpj).get();

    print(' >> Auth Repository.fetchCnpj $cnpj ');

    if (doc != null) {
      return doc.data()
        // ..['docRef'] = doc.reference
        ..['docId'] = doc.id;
    } else {
      return null;
    }
  }

  // Future<Map<String, dynamic>> fetchCnpj(String cnpj) async {
  //   //var query = await Firestore.instance
  //   var doc = await Firestore.instance.collection('CNPJS').document(cnpj).get();

  //   print(' >> AuthRepos.fetchCnpj : $cnpj ');

  //   return doc;
  // }

  //dispose will be called automatically
  @override
  void dispose() {}
}
