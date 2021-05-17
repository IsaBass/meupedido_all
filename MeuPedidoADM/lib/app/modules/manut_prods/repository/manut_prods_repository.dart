import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_controller.dart';

import 'manut_prods_repository_interf.dart';

class ManutProdsRepository extends Disposable implements IManutProdsRepository {
  final AppController _appController;

  ManutProdsRepository(this._appController);

  Future<List<Map<String, dynamic>>> allCategorias() async {
    //
    var docs = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .getDocuments();

    print(' >>> manut prod categs REPOSITORY ---- ALL CATEGORIAS ');

    if (docs == null || docs.documents.isEmpty) {
      return null;
    }
    return docs.documents.map((e) => e.data..['docId'] = e.documentID).toList();
    //
  }

  Future<List<Map<String, dynamic>>> getProdsCateg(int codCateg) async {
    ///
    var docs = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('produtos')
        .where('codCateg', isEqualTo: codCateg)
        .orderBy('descricao')
        .getDocuments();

    var map = List<Map<String, dynamic>>();
    map = [];

    map.addAll(
        docs.documents.map((e) => e.data..['docId'] = e.documentID).toList());

    return map;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
