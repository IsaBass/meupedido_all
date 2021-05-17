import 'package:flutter_modular/flutter_modular.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'cnpj_model.dart';
import 'cnpj_repository_interf.dart';

class CnpjRepository extends Disposable implements ICnpjRepository {
  //
  //
  Future<Map<String, dynamic>> fetchCnpj(String cnpj) async {
    //var query = await Firestore.instance
    var doc = await Firestore.instance.collection('CNPJS').document(cnpj).get();

    print(' >> CNPJ Repository.fetchCnpj $cnpj ');

    if (doc != null) {
      return doc.data
        ..['docRef'] = doc.reference
        ..['docId'] = doc.documentID;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchIdentificador(String identificador) async {
    //var query = await Firestore.instance
    var doc = await Firestore.instance
        .collection('CNPJS')
        .where('identificador', isEqualTo: identificador)
        .limit(1)
        .getDocuments();

    if (doc == null || doc.documents == null || doc.documents.length == 0) {
      return null;
    }

    print(' >> CNPJ Repository.fetchIdentificador $identificador ');
    return doc.documents[0].data
      ..['docRef'] = doc.documents[0].reference
      ..['docId'] = doc.documents[0].documentID;

    // return doc.documents[0];
  }

  Future<String> descricaoCnpj(String cnpj) async {
    //var query = await Firestore.instance
    if (cnpj.isEmpty) return '';

    var doc = await Firestore.instance.collection('CNPJS').document(cnpj).get();

    print(' >> CNPJ Repository.descricaoCnpj $cnpj ');

    if (doc.data != null) {
      return doc.data['descricao'];
    } else {
      return '';
    }
  }

  Future<List<Map<String, dynamic>>> getAllCnpjs() async {
    var query = await Firestore.instance.collection('CNPJS').getDocuments();

    print(' >> CNPJ Repository.getAllCnpjs');

    return query.documents
        .map((e) => e.data
          ..['docRef'] = e.reference
          ..['docId'] = e.documentID)
        .toList();
  }

  // Future<QuerySnapshot> getFiliais(String cnpj) async {
  //   var query = await Firestore.instance
  //       .collection('CNPJS')
  //       .document(cnpj)
  //       .collection('filiais')
  //       .getDocuments();

  //   print(' >> CNPJ Repository.get Filiais');

  //   return query;
  // }

  Future saveCNPJ(CnpjModel emp) async {
    // salva dados de CNPJS
    await Firestore.instance
        .collection('CNPJS')
        .document(emp.docId)
        .setData(emp.toJson(), merge: true);

    // // atualiza todas as 'filiais'
    // for (var fil in emp.dadosFiliais) {
    //   await emp.docRef
    //       .collection('filiais')
    //       .document(fil.cnpj)
    //       .setData(fil.toJson(), merge: true);
    // }

    print(' >> CNPJ Repository.saveCNPJ');
  }

  Future saveNovoCNPJ(CnpjModel emp) async {
    await Firestore.instance
        .collection('CNPJS')
        .document(emp.docId)
        .setData(emp.toJson());

    // // atualiza todas as 'filiais'
    // for (var fil in emp.dadosFiliais) {
    //   await emp.docRef
    //       .collection('filiais')
    //       .document(fil.cnpj)
    //       .setData(fil.toJson(), merge: true);
    // }

    print(' >> CNPJ Repository.save NOVO CNPJ');
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
