import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';
part 'search_controller.g.dart';

class SearchController = _SearchControllerBase with _$SearchController;

abstract class _SearchControllerBase with Store {
  final AppController _appController = AppModule.to.get();

  @observable
  ObservableList<ProdutoModel> prods;

  @observable
  bool isLoading = false;

  @action
  Future<void> buscaProduto(String filtro) async {
    isLoading = true;
    //
    var lAux = <ProdutoModel>[];

    var docs = await _appController.cnpjAtivoDocRef
        .collection('produtos')
        .where('descricao', isGreaterThanOrEqualTo: filtro)
        .where('descricao', isLessThanOrEqualTo: '$filtro\uF7FF')
        .limit(30)
        .orderBy('descricao')
        .getDocuments();

    if (docs != null) {
      lAux.addAll(docs.documents.map((d) {
        var m = d.data;
        m['docId'] = d.documentID;
        return ProdutoModel.fromJson(m);
      }).toList());
    }

    prods = lAux.asObservable();
    isLoading = false;
  }
}
