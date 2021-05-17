import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'list_enderecos_interf_repository.dart';

class ListEnderecosRepository extends Disposable
    implements ListEnderecosRepositoryI {
  final AppController _appController = AppModule.to.get();

  @override
  Future<List<Map>> getEnderecos() async {
    //
    var docs = await _appController.userAtualDocRef
        .collection('enderecos')
        .getDocuments();
    //
    List<Map> lAux = [];
    for (var doc in docs.documents) {
      lAux.add(doc.data..['docId'] = doc.documentID);
    }

    return lAux;
    //
  }

  @override
  Future<void> excluiEndereco(String idEnd) async {
    await _appController.userAtualDocRef
        .collection('enderecos')
        .document(idEnd)
        .delete();
  }

  @override
  void dispose() {}
}
