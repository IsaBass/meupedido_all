import 'package:MeuPedido/app/app_repository_interf.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

class AppRepository extends Disposable implements IAppRepository {
  final CNPJSController _cnpjsController;

  AppRepository(this._cnpjsController);

  Future<Map<String, dynamic>> getCnpjConfigs() async {
    //
    var docs = await _cnpjsController.cnpjAtivo.docRef
        .collection('cadastro')
        .getDocuments();
        
    if (docs.documents.isNotEmpty) {
      return docs.documents[0].data;
    } else {
      return {};
    }
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
