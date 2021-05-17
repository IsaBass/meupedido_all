import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'repository/manut_categs_repository.dart';

part 'manut_categs_controller.g.dart';

class ManutCategsController = _ManutCategsBase with _$ManutCategsController;

abstract class _ManutCategsBase with Store {
  final ManutCategsRepository _repository;

  _ManutCategsBase(this._repository);

  @observable
  bool isLoading = false;
  @observable
  bool isLoadingList = false;
  // @observable
  // CategoriaModel categSelecionada;
  @observable
  ObservableList<CategoriaModel> categs;

  @action
  Future<void> recarregaAllCategs() async {
    isLoadingList = true;
    var listaAux = <CategoriaModel>[];
    categs = listaAux.asObservable();

    var query = await _repository.allCategorias();

    for (var doc in query) {
      var ct = CategoriaModel.fromJson(doc);
      ct.grupoAdicionais = await getCategGrpOpcionais(ct.docId);
      listaAux.add(ct);
    }
    categs = listaAux.asObservable();

    // if (categSelecionada == null && listaAux.length > 0)
    //   categSelecionada = listaAux[0];

    isLoadingList = false;
  }

  Future<List<AdicionalGrpModel>> getCategGrpOpcionais(String categId) async {
    // isLoading = true;
    var listaAux = <AdicionalGrpModel>[];
    //
    var query = await _repository.getCategGrpOpcionais(categId);
    //
    // for (var doc in query) {
    //   listaAux.add(AdicionalGrpModel.fromJson(doc));
    // }
    if (query != null) {
      listaAux.addAll(query.map((e) => AdicionalGrpModel.fromJson(e)).toList());
    }
    // isLoading = false;
    return listaAux;
  }

  @action
  Future<void> updateCateg(CategoriaModel categ) async {
    ////
    isLoading = true;

    if (categ.docId?.isNotEmpty ?? false) {
      await _repository.updateCateg(categ);
    } else {
      //
      await _repository.novaCateg(categ);

      categs.add(categ);
      //
    }

    isLoading = false;

    ///
  }

  @action
  Future<void> excluirCateg(CategoriaModel categ) async {
    isLoading = true;

    if (categ.docId?.isNotEmpty ?? false) {
      await _repository.excluirCateg(categ);
    }

    categs.remove(categ);

    isLoading = false;
  }

  @action
  Future<bool> existeProdCateg(CategoriaModel categ) async {
    isLoading = true;

    if (categ.docId?.isNotEmpty ?? false) return false;

    var b = await _repository.existeProds(categ.codCateg);

    isLoading = false;
    return b;
  }
}
