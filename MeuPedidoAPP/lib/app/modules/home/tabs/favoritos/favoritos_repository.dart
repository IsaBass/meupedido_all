import 'package:MeuPedido/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'favoritos_interf_repository.dart';

class FavoritosRepository extends Disposable implements FavoritosRepositoryI {
  final AppController _appController;

  FavoritosRepository(this._appController);

  Future<Map<String, dynamic>> getProdutoFav(String idProd) async {
    var dR = _appController.cnpjAtivoDocRef;

    var doc = await dR.collection('produtos').doc(idProd).get();
    if (doc != null) {
      return doc.data()..['docId'] = doc.id;
    } else {
      return null;
    }
  }

  @override
  void dispose() {}
}
