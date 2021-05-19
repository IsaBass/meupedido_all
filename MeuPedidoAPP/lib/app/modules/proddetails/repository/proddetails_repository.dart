import 'package:MeuPedido/app/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'proddetails_interf_repository.dart';

class ProddetailsRepository extends Disposable
    implements IProddetailsRepository {
  final AppController _appController;

  ProddetailsRepository(this._appController);

  DocumentReference get cnpjAtivoDocRef => FirebaseFirestore.instance
      .collection("CNPJS")
      .doc(_appController.cnpjAtivo.docId);

  Future<List<Map>> getGrpOpcionais(String idProduto) async {
    var docs = await cnpjAtivoDocRef
        .collection('produtos')
        .doc(idProduto)
        .collection('opcionais')
        .orderBy('ordem')
        .get();

    return docs.docs.map((e) => e.data()..["docId"] = e.id).toList();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
