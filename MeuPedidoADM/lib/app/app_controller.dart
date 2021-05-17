import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

class AppController = _AppBase with _$AppController;

abstract class _AppBase with Store {
  final AuthController _authController;
  final CNPJSController _cnpjsController;

  @observable
  int value = 0;

  _AppBase(this._authController, this._cnpjsController);

  @action
  void increment() {
    value++;
  }

  ///
  DocumentReference get userAtualDocRef => _authController.userAtual.docRef;
  DocumentReference get cnpjAtivoDocRef => _cnpjsController.cnpjAtivo.docRef;
  String get userAtualDocId => _authController.userAtual.firebasebUser.uid;
  String get cnpjAtivoDocId =>
      _cnpjsController.cnpjAtivo.docId; // docId é o CNPJ
  //

  Future<CnpjConfigsModel> getCnpjConfigs() async {
    //
    var docs = await _cnpjsController.cnpjAtivo.docRef
        .collection('cadastro')
        .getDocuments();
    return CnpjConfigsModel.fromJson(docs.documents[0].data);
    //
  }
}
