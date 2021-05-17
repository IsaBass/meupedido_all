import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'proddetails_interf_repository.dart';

class ProddetailsRepository extends Disposable
    implements IProddetailsRepository {
  final AppController _appController;

  ProddetailsRepository(this._appController);

  Future<List<Map>> getGrpOpcionais(String idProduto) async {
    var docs = await _appController.cnpjAtivoDocRef
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
