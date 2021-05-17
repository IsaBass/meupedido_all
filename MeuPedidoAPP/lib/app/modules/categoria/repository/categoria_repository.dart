import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_interf_repository.dart';

class CategoriaRepository extends Disposable implements ICategoriaRepository {
  ///
  final AppController _appController = AppModule.to.get<AppController>();

  Future<List<Map>> prodsCategoria(int codCateg) async {
    List<Map> lAux = [];

    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('codCateg', isEqualTo: codCateg)
        .getDocuments();

    if (docs == null) return lAux;

    for (var doc in docs.documents) {
      lAux.add(doc.data..['docId'] = doc.documentID);
    }

    print(' >>> CATEG REPOSITORY ---- prods da CATEGORIA $codCateg ');
    return lAux;
  }

  Future<List<Map>> getProdsDestaqueGeral() async {
    List<Map> lAux = [];
    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('destaqueGeral', isEqualTo: true)
        .getDocuments();

    for (var doc in docs.documents) {
      var m = doc.data;
      m['docId'] = doc.documentID;
      lAux.add(m);
    }
    return lAux;
  }

  Future<List<Map>> getProdsTodosDestaque() async {
    List<Map> lAux = [];
    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('destaqueCateg', isEqualTo: true)
        .getDocuments();

    for (var doc in docs.documents) {
      var m = doc.data;
      m['docId'] = doc.documentID;
      lAux.add(m);
    }
    return lAux;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
