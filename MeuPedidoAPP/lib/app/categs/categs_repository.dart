import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'categs_interf_repository.dart';

class CategsRepository extends Disposable implements ICategsRepository {
  Future<List<Map<String, dynamic>>> allCategorias(String cnpj) async {
    var docRef = FirebaseFirestore.instance.collection("CNPJS").doc(cnpj);

    var docs = await docRef.collection('categorias').get();

    print(' >>> CATEG REPOSITORY ---- ALL CATEGORIAS ');

    return docs.docs.map((doc) => doc.data()..['docId'] = doc.id).toList();
  }

  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(
      String cnpj, String docIdCateg) async {
    var docRef = FirebaseFirestore.instance
        .collection("CNPJS")
        .doc(cnpj)
        .collection('categorias')
        .doc(docIdCateg);

    var docs = await docRef.collection('opcionais').orderBy('ordem').get();

    return docs.docs.map((doc) => doc.data()..['docId'] = doc.id).toList();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
