import 'package:MeuPedido/app/app_controller.dart';

import 'package:flutter_modular/flutter_modular.dart';

import 'categs_interf_repository.dart';

class CategsRepository extends Disposable implements ICategsRepository {
  final AppController _appController = Modular.get<AppController>();

  Future<List<Map<String, dynamic>>> allCategorias() async {
    var docRef = _appController.cnpjAtivoDocRef;

    var docs = await docRef.collection('categorias').get();

    print(' >>> CATEG REPOSITORY ---- ALL CATEGORIAS ');

    return docs.docs.map((doc) => doc.data()..['docId'] = doc.id).toList();
  }

  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(
      String docIdCateg) async {
    var docRef =
        _appController.cnpjAtivoDocRef.collection('categorias').doc(docIdCateg);

    var docs = await docRef.collection('opcionais').orderBy('ordem').get();

    return docs.docs.map((doc) => doc.data()..['docId'] = doc.id).toList();
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
