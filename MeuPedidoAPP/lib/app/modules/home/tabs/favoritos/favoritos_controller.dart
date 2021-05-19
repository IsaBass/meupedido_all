import 'package:MeuPedido/app/app_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'favoritos_interf_repository.dart';

part 'favoritos_controller.g.dart';

class FavoritosController = _FavoritosBase with _$FavoritosController;

abstract class _FavoritosBase with Store {
  final AppController _appController;

  //
  final FavoritosRepositoryI _repository;
  //
  _FavoritosBase(this._repository, this._appController);

  @observable
  ObservableList<ProdutoModel> favs;

  @observable
  bool isLoading = false;

  @action
  Future<void> getProdutoFav() async {
    isLoading = true;
    //
    var lAux = <ProdutoModel>[];

    for (var p in _appController.getFavoritos) {
      var doc = await _repository.getProdutoFav(p);
      if (doc != null) {
        lAux.add(ProdutoModel.fromJson(doc));
      }
    }

    favs = lAux.asObservable();
    isLoading = false;
  }

  @action
  void excluirFavorito(ProdutoModel prod) {
    _appController.changeFavorito(prod.codigo);
    favs.remove(prod);
  }
}
