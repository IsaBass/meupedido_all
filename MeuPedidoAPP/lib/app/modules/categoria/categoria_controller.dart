import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:meupedido_core/meupedido_core.dart';
import 'package:MeuPedido/app/categs/categs_controller.dart';

import 'repository/categoria_interf_repository.dart';

part 'categoria_controller.g.dart';

class CategoriaController = _CategoriaBase with _$CategoriaController;

abstract class _CategoriaBase with Store {
  final ICategoriaRepository _repository;
  final CategsController _categsController = Modular.get<CategsController>();

  _CategoriaBase(this._repository) {
    fetchProdsDestaqueGeral();
  }

  ///
  @observable
  bool isLoading = false;

  @observable
  ObservableList<ProdutoModel> listProds;
  @observable
  ObservableList<ProdutoModel> listDestaques;

  ///
  @observable
  int codCategSelecionada = 0;

  @action
  Future<void> setCategSelecionada(int cod) async {
    isLoading = true;
    codCategSelecionada = cod;
    await fetchProdsCategoria();
    isLoading = false;
  }

  @computed
  String get nomeSelecionada => _categsController.categs
      .firstWhere((e) => e.codCateg == codCategSelecionada)
      .descricao;
  //

  @action
  Future<void> fetchProdsCategoria() async {
    var lAux = <ProdutoModel>[];
    listProds = lAux.asObservable();
    var lDest = <ProdutoModel>[];
    listDestaques = lDest.asObservable();

    var maps = await _repository.prodsCategoria(codCategSelecionada);

    for (var doc in maps) {
      lAux.add(ProdutoModel.fromJson(doc));

      if (doc['destaqueCateg'] == true || doc['destaqueGeral'] == true) {
        lDest.add(ProdutoModel.fromJson(doc));
      }
    }

    listProds = lAux.asObservable();
    listDestaques = lDest.asObservable();
  }

  ///
  @observable
  ObservableList<ProdutoModel> prodsDestaqueGeral;
  @observable
  ObservableList<ProdutoModel> prodsTodosDestaque;
  @action
  Future<void> fetchProdsDestaqueGeral() async {
    var lAux = <ProdutoModel>[];
    var query = await _repository.getProdsDestaqueGeral();

    lAux.addAll(query.map((e) => ProdutoModel.fromJson(e)).toList());
    prodsDestaqueGeral = lAux.asObservable();
    //
    query = await _repository.getProdsTodosDestaque();
    for (var doc in query) {
      if (lAux.firstWhere(
            (e) => e.codigo == doc['docId'],
            orElse: () => null,
          ) ==
          null) {
        lAux.add(ProdutoModel.fromJson(doc));
      }
    }

    prodsTodosDestaque = lAux.asObservable();
  }
  //

}
