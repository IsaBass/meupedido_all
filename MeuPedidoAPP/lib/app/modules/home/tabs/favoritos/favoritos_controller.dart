import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'favoritos_interf_repository.dart';

part 'favoritos_controller.g.dart';

class FavoritosController = _FavoritosBase with _$FavoritosController;

abstract class _FavoritosBase with Store {
  final AuthController _authController = Modular.get();
  //
  final FavoritosRepositoryI _repository;
  //
  _FavoritosBase(this._repository);

  @observable
  ObservableList<ProdutoModel> favs;

  @observable
  bool isLoading = false;

  @action
  Future<void> getProdutoFav() async {
    isLoading = true;
    //
    var lAux = <ProdutoModel>[];

    for (var p in _authController.favoritos) {
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
    _authController.changeFavorito(prod.codigo);
    favs.remove(prod);
  }
}
