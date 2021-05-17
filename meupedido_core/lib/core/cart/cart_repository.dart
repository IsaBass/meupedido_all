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
    var query = await FirebaseFirestore.instance
        .collection("users")
        .doc(userAtualID)
        .collection('cart$cnpjAtivo')
        .get();

    for (var doc in query.docs) {
      doc.reference.delete();
    }
  }

  Future<String> addCarrinho(
    Map data, {
    @required String cnpjAtivo,
    @required String userAtualID,
  }) async {
    //
    var doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(userAtualID)
        .collection('cart$cnpjAtivo')
        .add(data);

    return doc.id;
  }

  void removeCarrinho(
    String idCart, {
    @required String cnpjAtivo,
    @required String userAtualID,
  }) {
    //
    FirebaseFirestore.instance
        .collection("users")
        .doc(userAtualID)
        .collection('cart$cnpjAtivo')
        .doc(idCart)
        .delete();
    //
  }

  Future<List<Map>> getCarrinho({
    @required String cnpjAtivo,
    @required String userAtualID,
  }) async {
    List<Map> lAux = [];

    //
    var docs = await FirebaseFirestore.instance
        .collection("users")
        .doc(userAtualID)
        .collection('cart$cnpjAtivo')
        .get();
    //
    for (var doc in docs.docs) {
      lAux.add(doc.data()..['docId'] = doc.id);
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
    await FirebaseFirestore.instance
        .collection("users")
        .doc(userAtualID)
        .collection('cart$cnpjAtivo')
        .doc(idCart)
        .set(data, SetOptions(merge: true));
    //
  }

  Future<Map<String, dynamic>> getProduto(
      String cnpjAtivo, String idProduto) async {
    //
    var docP = await FirebaseFirestore.instance
        .collection("CNPJS")
        .doc(cnpjAtivo)
        .collection('produtos')
        .doc(idProduto)
        .get();
    //
    if (docP != null) {
      return docP.data()..['docId'] = docP.id;
    } else {
      return null;
    }
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
