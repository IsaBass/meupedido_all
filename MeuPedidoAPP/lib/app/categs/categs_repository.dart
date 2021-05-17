import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'categs_interf_repository.dart';

class CategsRepository extends Disposable implements ICategsRepository {
  
  final AppController _appController = AppModule.to.get<AppController>();

  Future<List<Map<String, dynamic>>> allCategorias() async {
    var docRef = _appController.cnpjAtivoDocRef;
    
    var docs =  await docRef.collection('categorias').getDocuments();

    print(' >>> CATEG REPOSITORY ---- ALL CATEGORIAS ');

    return docs.documents.map((doc) => doc.data..['docId'] = doc.documentID ).toList();

  }


  Future<List<Map<String, dynamic>>> getCategGrpOpcionais(String docIdCateg) async {

    var docRef = _appController.cnpjAtivoDocRef
    .collection('categorias').document(docIdCateg);
   
    var docs = await docRef.collection('opcionais')
    .orderBy('ordem')
    .getDocuments();

    return docs.documents.map((doc) => doc.data..['docId'] = doc.documentID ).toList();
  }


  //dispose will be called automatically
  @override
  void dispose() {}
}
