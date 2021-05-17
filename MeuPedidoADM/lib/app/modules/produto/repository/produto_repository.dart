import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_controller.dart';

import 'produto_repository_interf.dart';

class ProdutoRepository extends Disposable implements IProdutoRepository {
  final AppController _appController;

  ProdutoRepository(this._appController);

  Future updateProd(Map prod) async {
    try {
      await Firestore.instance
          .collection('CNPJS')
          .document(_appController.cnpjAtivoDocId)
          .collection('produtos')
          .document(prod['codigo'])
          .setData(prod, merge: true);
    } catch (_) {
      return;
    }
  }

  Future<String> novoProd(Map prod) async {
    //
    try {
      var doc = await Firestore.instance
          .collection('CNPJS')
          .document(_appController.cnpjAtivoDocId)
          .collection('produtos')
          .add(prod);

      return doc.documentID;
    } catch (e) {
      return null;
      // throw Exception(e);
    }
  }

  ///

  Future<List<Map<String, dynamic>>> getOpcionais(
      String prodId, String idCateg) async {
    //
    if (prodId.isEmpty || prodId == null) return null;
    //
    List<Map<String, dynamic>> listAux = <Map<String, dynamic>>[];
    //
    try {
      ////
      var docs = await Firestore.instance
          .collection('CNPJS')
          .document(_appController.cnpjAtivoDocId)
          .collection('produtos')
          .document(prodId)
          .collection('opcionais')
          .getDocuments();

      if (!(docs == null || docs.documents.isEmpty)) {
        ///
        listAux.addAll(docs.documents
            .map((e) => e.data
              ..['docId'] = e.documentID
              ..['origem'] = "P"
              ..['idOrigem'] = prodId)
            .toList());
      }

      ////
      docs = await Firestore.instance
          .collection('CNPJS')
          .document(_appController.cnpjAtivoDocId)
          .collection('categorias')
          .document(idCateg)
          .collection('opcionais')
          .getDocuments();

      if (!(docs == null || docs.documents.isEmpty)) {
        //
        listAux.addAll(docs.documents
            .map((e) => e.data
              ..['docId'] = e.documentID
              ..['origem'] = "C"
              ..['idOrigem'] = idCateg)
            .toList());
      }

      ///
      return listAux;
      //
    } catch (e) {
      return null;
      // throw Exception(e);
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
