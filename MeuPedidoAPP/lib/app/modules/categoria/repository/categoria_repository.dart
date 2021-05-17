import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categoria_interf_repository.dart';

class CategoriaRepository extends Disposable implements ICategoriaRepository {
  ///
  final AppController _appController = AppModule().getBind<AppController>();

  Future<List<Map>> prodsCategoria(int codCateg) async {
    List<Map> lAux = [];

    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('codCateg', isEqualTo: codCateg)
        .get();

    if (docs == null) return lAux;

    for (var doc in docs.docs) {
      lAux.add(doc.data()..['docId'] = doc.id);
    }

    print(' >>> CATEG REPOSITORY ---- prods da CATEGORIA $codCateg ');
    return lAux;
  }

  Future<List<Map>> getProdsDestaqueGeral() async {
    List<Map> lAux = [];
    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('destaqueGeral', isEqualTo: true)
        .get();

    for (var doc in docs.docs) {
      var m = doc.data();
      m['docId'] = doc.id;
      lAux.add(m);
    }
    return lAux;
  }

  Future<List<Map>> getProdsTodosDestaque() async {
    List<Map> lAux = [];
    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('destaqueCateg', isEqualTo: true)
        .get();

    for (var doc in docs.docs) {
      var m = doc.data();
      m['docId'] = doc.id;
      lAux.add(m);
    }
    return lAux;
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
