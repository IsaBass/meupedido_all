import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'repository/manut_prods_repository_interf.dart';

part 'manut_prods_controller.g.dart';

class ManutProdsController = _ManutProdsBase with _$ManutProdsController;

abstract class _ManutProdsBase with Store {
  final IManutProdsRepository _repository;

  @observable
  bool isLoading = false;
  @observable
  bool isLoadingList = false;
  @observable
  CategoriaModel categSelecionada;
  @observable
  ObservableList<CategoriaModel> categs;
  @observable
  ObservableList<ProdutoModel> prods;

  _ManutProdsBase(this._repository);

  @action
  Future<void> recarregaAllCategs() async {
    isLoadingList = true;
    //
    var query = await _repository.allCategorias();
    //
    categs = <CategoriaModel>[].asObservable();
    //
    categs.addAll(
        query.map((e) => CategoriaModel.fromJson(e)).toList().asObservable());
    //
    if (categSelecionada == null && categs.length > 0)
      setCategSelecionada(categs[0]);
    //
    isLoadingList = false;
  }

  @action
  Future<void> setCategSelecionada(CategoriaModel categ) async {
    categSelecionada = categ;
    await carregaProds();
    return;
  }

  @action
  Future<void> carregaProds() async {
    isLoading = true;
    //
    prods = <ProdutoModel>[].asObservable();
    var maps = await _repository.getProdsCateg(categSelecionada.codCateg);
    //
    prods.addAll(
        maps.map((e) => ProdutoModel.fromJson(e)).toList().asObservable());
    //
    isLoading = false;
  }
}
