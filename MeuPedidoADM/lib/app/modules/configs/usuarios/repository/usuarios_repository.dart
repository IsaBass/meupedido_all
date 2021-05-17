import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore_all/cloud_firestore_all.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'usuarios_repository_interf.dart';

class UsuariosRepository extends Disposable implements IUsuariosRepository {
  //
  //
  Future<List<Map<String, dynamic>>> getAllUsuarios(String cnpj) async {
    /// firestore_all nao funciona com arrayContains
    var query = await Firestore.instance.collection('users').where(
      "empresas",
      arrayContainsAny: [
        {'cnpj': cnpj, 'status': 'PEND'},
        {'cnpj': cnpj, 'status': 'OK'},
        {'cnpj': cnpj, 'status': 'BLOCK'},
      ],
    ).getDocuments();

    print(' >> USUARIOS Repository. get all usuarios : $cnpj ');

    if (query == null || query.documents.isEmpty) return null;

    return query.documents
        .map((e) => e.data..['docRef'] = e.reference)
        .toList();
  }

  Future salvarUsuario(DocumentReference docRef, Map dados) async {
    await docRef.setData(dados, merge: true);
    print(' >> USUArIOS Repository.Salvar Usuario ');
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
