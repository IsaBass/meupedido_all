import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedidoADM/app/app_controller.dart';

import 'altera_adic_interf.dart';

class AlteraAdicRepository extends Disposable implements IAlteraAdicRepository {
  final AppController _appController = Modular.get();

  @override
  Future<String> novoGrupoCateg(
      Map<String, dynamic> mGrupo, String idCateg) async {
    ////
    var doc = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .document(idCateg)
        .collection('opcionais')
        .add(mGrupo);

    return doc.documentID;
  }

  @override
  Future<String> novoGrupoProd(
      Map<String, dynamic> mGrupo, String idProduto) async {
    //

    var doc = await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('produtos')
        .document(idProduto)
        .collection('opcionais')
        .add(mGrupo);

    return doc.documentID;
  }

  @override
  Future<String> saveGrupoCateg(
      Map<String, dynamic> mGrupo, String idCateg) async {
    await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('categorias')
        .document(idCateg)
        .collection('opcionais')
        .document(mGrupo['docId'])
        .setData(mGrupo, merge: true);

    return (mGrupo['docId']);
  }

  @override
  Future<String> saveGrupoProd(
      Map<String, dynamic> mGrupo, String idProduto) async {
    await Firestore.instance
        .collection('CNPJS')
        .document(_appController.cnpjAtivoDocId)
        .collection('produtos')
        .document(idProduto)
        .collection('opcionais')
        .document(mGrupo['docId'])
        .setData(mGrupo, merge: true);

    return mGrupo['docId'];
  }

  @override
  void dispose() {}
}
