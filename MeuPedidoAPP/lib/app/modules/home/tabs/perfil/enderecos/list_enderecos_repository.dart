import 'package:MeuPedido/app/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'list_enderecos_interf_repository.dart';

class ListEnderecosRepository extends Disposable
    implements ListEnderecosRepositoryI {
  //
  final AppController _appController;
  //
  DocumentReference get userAtualDocRef => FirebaseFirestore.instance
      .collection("users")
      .doc(_appController.userAtual.uid);

  ListEnderecosRepository(this._appController);

  @override
  Future<List<Map>> getEnderecos() async {
    //
    var docs = await userAtualDocRef.collection('enderecos').get();
    //
    List<Map> lAux = [];

    for (var doc in docs.docs) {
      lAux.add(doc.data()..['docId'] = doc.id);
    }

    return lAux;
    //
  }

  @override
  Future<void> excluiEndereco(String idEnd) async {
    await userAtualDocRef.collection('enderecos').doc(idEnd).delete();
  }

  @override
  void dispose() {}
}
