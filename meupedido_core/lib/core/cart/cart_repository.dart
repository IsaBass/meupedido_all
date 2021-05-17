import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'cart_repository_interf.dart';

class CartRepository extends Disposable implements ICartRepository {
  //
  //
  Future<void> excluiCarrinho({
    @required String cnpjAtivo,
    @required String userAtualID,
  }) async {
    //
    var query = await Firestore.instance
        .collection("users")
        .document(userAtualID)
        .collection('cart$cnpjAtivo')
        .getDocuments();

    for (var doc in query.documents) {
      doc.reference.delete();
    }
  }

  Future<String> addCarrinho(
    Map data, {
    @required String cnpjAtivo,
    @required String userAtualID,
  }) async {
    //
    var doc = await Firestore.instance
        .collection("users")
        .document(userAtualID)
        .collection('cart$cnpjAtivo')
        .add(data);

    return doc.documentID;
  }

  void removeCarrinho(
    String idCart, {
    @required String cnpjAtivo,
    @required String userAtualID,
  }) {
    //
    Firestore.instance
        .collection("users")
        .document(userAtualID)
        .collection('cart$cnpjAtivo')
        .document(idCart)
        .delete();
    //
  }

  Future<List<Map>> getCarrinho({
    @required String cnpjAtivo,
    @required String userAtualID,
  }) async {
    List<Map> lAux = [];

    //
    var docs = await Firestore.instance
        .collection("users")
        .document(userAtualID)
        .collection('cart$cnpjAtivo')
        .getDocuments();
    //
    for (var doc in docs.documents) {
      lAux.add(doc.data..['docId'] = doc.documentID);
    }
    return lAux;
  }

  Future<void> updItemCarrinho(
    String idCart,
    Map data,
    String cnpjAtivo,
    String userAtualID,
  ) async {
    //
    await Firestore.instance
        .collection("users")
        .document(userAtualID)
        .collection('cart$cnpjAtivo')
        .document(idCart)
        .setData(data, merge: true);
    //
  }

  Future<Map<String, dynamic>> getProduto(
      String cnpjAtivo, String idProduto) async {
    //
    var docP = await Firestore.instance
        .collection("CNPJS")
        .document(cnpjAtivo)
        .collection('produtos')
        .document(idProduto)
        .get();
    //
    if (docP != null) {
      return docP.data..['docId'] = docP.documentID;
    } else {
      return null;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
