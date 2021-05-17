import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'repository/produto_repository_interf.dart';

part 'produto_controller.g.dart';

class ProdutoController = _ProdutoBase with _$ProdutoController;

abstract class _ProdutoBase with Store {
  final IProdutoRepository _repository;

  _ProdutoBase(this._repository);

  @observable
  bool isLoading = false;

  @action
  Future saveProd(ProdutoModel prod) async {
    isLoading = true;
    try {
      if (prod.codigo == null || prod.codigo.isEmpty)
        await _novoProd(prod);
      else
        await _updateProd(prod);
    } catch (_) {
      isLoading = false;
      return null;
    }

    isLoading = false;
    return null;
  }

  @action
  Future _updateProd(ProdutoModel prod) async {
    isLoading = true;
    try {
      await _repository.updateProd(prod.toJson());
    } catch (_) {
      isLoading = false;
      return null;
    }

    isLoading = false;
  }

  @action
  Future _novoProd(ProdutoModel prod) async {
    //
    try {
      var novoCod = await _repository.novoProd(prod.toJson());
      prod.codigo = novoCod;
      return;
    } catch (e) {
      throw Exception(e);
    }
  }

  ///
  @action
  Future getOpcionais(ProdutoModel prod, String idCateg) async {
    //
    if (prod.codigo.isEmpty || prod.codigo == null) return;
    //
    try {
      ////
      var docs = await _repository.getOpcionais(prod.codigo, idCateg);

      prod.grupoAdicionais.clear();
      if (docs != null) {
        prod.grupoAdicionais
            .addAll(docs.map((e) => (AdicionalGrpModel.fromJson(e))).toList());
      }

      return;
    } catch (e) {
      throw Exception(e);
    }
  }
  //
}
