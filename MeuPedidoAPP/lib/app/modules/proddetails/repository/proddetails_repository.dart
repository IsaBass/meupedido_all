import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'proddetails_interf_repository.dart';

class ProddetailsRepository extends Disposable implements IProddetailsRepository {
  final AppController _appController;

  ProddetailsRepository(this._appController);

  

  Future<List<Map>> getGrpOpcionais(String idProduto) async {

    var docs = await _appController.cnpjAtivoDocRef
    .collection('produtos')
    .document(idProduto)
    .collection('opcionais')
    .orderBy('ordem')
    


    .getDocuments();

    return docs.documents.map( (e) => e.data..["docId"] = e.documentID ).toList();

  }



  //dispose will be called automatically
  @override
  void dispose() {}
}
