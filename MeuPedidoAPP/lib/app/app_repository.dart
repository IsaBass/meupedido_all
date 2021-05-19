import 'package:MeuPedido/app/app_repository_interf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppRepository extends Disposable implements IAppRepository {
  @override
  Future<Map<String, dynamic>> getCnpjConfigs(String cnpj) async {
    //
    var docs = await FirebaseFirestore.instance
        .collection("CNPJS")
        .doc(cnpj)
        .collection('cadastro')
        .get();

    if (docs.docs.isNotEmpty) {
      return docs.docs[0].data();
    } else {
      return {};
    }
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
