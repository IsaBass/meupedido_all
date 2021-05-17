import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'manut_categs_repository_interf.dart';

class ManutCategsRepository extends Disposable
    implements IManutCategsRepository {
  final AppController _appController;

  ManutCategsRepository(this._appController);

  Future<List<Map<String, dynamic>>> allCategorias() async {
    //
    var docs = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .getDocuments();

    print(' >>> CATEG REPOSITORY ---- ALL CATEGORIAS ');

    if (docs == null || docs.documents.isEmpty) {
      return null;
    }
    return docs.documents.map((e) => e.data..['docId'] = e.documentID).toList();
    //
  }

  Future<void> updateCateg(CategoriaModel categ) async {
    await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .document(categ.docId)
        .setData(categ.toJson(), merge: true);

    print(' >>> CATEG REPOSITORY ---- update ${categ.descricao} ');
  }

  Future<void> excluirCateg(CategoriaModel categ) async {
    await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .document(categ.docId)
        .delete();

    print(' >>> CATEG REPOSITORY ---- delete ${categ.descricao} ');
  }

  Future<void> novaCateg(CategoriaModel categ) async {
    ///
    var doc = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .add(categ.toJson());

    categ.docId = doc.documentID;

    print(' >>> CATEG REPOSITORY ---- nova categ ${categ.descricao} ');
  }

  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(
      String categId) async {
    //
    var docs = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .document(categId)
        .collection('opcionais')
        .orderBy('ordem')
        .getDocuments();
    //
    if (docs == null || docs.documents.isEmpty) {
      return null;
    }
    return docs.documents
        .map((e) => e.data
          ..['docId'] = e.documentID
          ..['origem'] = "C"
          ..['idOrigem'] = categId)
        .toList();
    //
  }

  Future<bool> existeProds(int codCateg) async {
    ///
    var docs = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('produtos')
        .where('codCateg', isEqualTo: codCateg)
        .limit(1)
        .getDocuments();

    //
    if (docs == null) return false;
    //
    return (docs.documents.length > 0);
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
