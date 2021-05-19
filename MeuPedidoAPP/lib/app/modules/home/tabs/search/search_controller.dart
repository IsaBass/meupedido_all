import 'package:MeuPedido/app/app_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final AppController _appController;

  @observable
  ObservableList<ProdutoModel> prods;

  @observable
  bool isLoading = false;

  _SearchControllerBase(this._appController);

  @action
  Future<void> buscaProduto(String filtro) async {
    isLoading = true;
    //
    var lAux = <ProdutoModel>[];

    var docs = await FirebaseFirestore.instance
        .collection("CNPJS")
        .doc(_appController.cnpjAtivo.docId)
        .collection('produtos')
        .where('descricao', isGreaterThanOrEqualTo: filtro)
        .where('descricao', isLessThanOrEqualTo: '$filtro\uF7FF')
        .limit(30)
        .orderBy('descricao')
        .get();

    if (docs != null) {
      lAux.addAll(docs.docs
          .map((d) => ProdutoModel.fromJson(d.data()..['docId'] = d.id))
          .toList());
    }

    prods = lAux.asObservable();
    isLoading = false;
  }
}
