import 'package:meupedido_core/core/auth/auth_controller.dart';
import 'package:meupedido_core/core/cnpjs/cnpjs_controller.dart';
import 'package:meupedido_core/models/pedido/cupomdesconto_model.dart';
import 'package:meupedido_core/models/produto_model.dart';
import 'package:mobx/mobx.dart';

import 'cart_repository_interf.dart';
import 'model_mobx/cart.item_model.dart';
import 'model_mobx/cart_model.dart';

part 'cart_controller.g.dart';

class CartController = _CartBase with _$CartController;

abstract class _CartBase with Store {
  final CNPJSController _cnpjsController;
  final AuthController _authController;
  final ICartRepository _repository;
  // final AppController _appController = AppModule.to.get();

  @observable
  CartModel cartAtual;

  _CartBase(this._repository, this._cnpjsController, this._authController) {
    cartAtual = CartModel();
  }

  @action
  Future<void> adicionarCarrinho(CartItemModel item) async {
    ////
    cartAtual.adicionarItem(item);
    item.docId = await _repository.addCarrinho(item.toJson(),
        userAtualID: _authController.userAtual.firebasebUser.uid,
        cnpjAtivo: _cnpjsController.cnpjAtivo.docId);
    //
  }

  @action
  void removeCarrinho(
      //DocumentReference userDocRef,
      CartItemModel item) {
    //
    // _authController.userAtual.firebasebUser.uid
    // _cnpjsController.cnpjAtivo.docId

    if (item.docId.isNotEmpty) {
      _repository.removeCarrinho(
        item.docId,
        userAtualID: _authController.userAtual.firebasebUser.uid,
        cnpjAtivo: _cnpjsController.cnpjAtivo.docId,
      );
    }
    cartAtual.removerItem(item);
  }

  @action
  Future<void> incrementItem(CartItemModel item) async {
    //
    item.incrementQtd();

    if (item.docId.isEmpty) {
      item.docId = await _repository.addCarrinho(
        item.toJson(),
        userAtualID: _authController.userAtual.firebasebUser.uid,
        cnpjAtivo: _cnpjsController.cnpjAtivo.docId,
        // cnpjAtivoDocRef: _cnpjsController.cnpjAtivo.docRef,
        // userAtualDocRef: _authController.userAtual.docRef,
      );
    } else {
      _repository.updItemCarrinho(
        item.docId,
        item.toJson(),
        _cnpjsController.cnpjAtivo.docId,
        _authController.userAtual.firebasebUser.uid,
      );
    }
  }

  @action
  Future<void> decrementItem(CartItemModel item) async {
    //
    item.decrementQtd();

    if (item.docId.isEmpty) {
      item.docId = await _repository.addCarrinho(
          // userDocRef,
          item.toJson(),
          userAtualID: _authController.userAtual.firebasebUser.uid,
          cnpjAtivo: _cnpjsController.cnpjAtivo.docId
          // cnpjAtivoDocRef: _cnpjsController.cnpjAtivo.docRef,
          // userAtualDocRef: _authController.userAtual.docRef,
          );
    } else {
      _repository.updItemCarrinho(
        item.docId,
        item.toJson(),
        _cnpjsController.cnpjAtivo.docId,
        _authController.userAtual.firebasebUser.uid,

        // _authController.userAtual.docRef,
        // _cnpjsController.cnpjAtivo.docRef,
      );
    }
  }

  @action
  Future<void> carregaCarrinhoUser() async {
    /////
    limparCarrinho();
    var query = await _repository.getCarrinho(
      userAtualID: _authController.userAtual.firebasebUser.uid,
      cnpjAtivo: _cnpjsController.cnpjAtivo.docId,
    );

    if (query == null) {
      return;
    }
    for (var doc in query) {
      var item = await cartItemModelfromJson(doc);
      var docP = await _repository.getProduto(
          _cnpjsController.cnpjAtivo.docId, item.idProduto);
      //
      if (docP != null && docP.isNotEmpty) {
        item.produto = ProdutoModel.fromJson(docP);
        item.produto.precoAtual = _getVlrProduto(item);
        cartAtual.itens.add(item);
      }
    }
  }

  double _getVlrProduto(CartItemModel item) {
    if ((item.adics?.length ?? 0) == 0) {
      return item.produto.precoAtual;
    }

    var dd = item.adics
        .firstWhere((e) => e.determinaPreco == true, orElse: () => null);

    if (dd != null) {
      return dd.valorUnit;
    } else {
      return item.produto.precoAtual;
    }
  }

  @action
  void limparCarrinho() {
    cartAtual.idUser = '';
    cartAtual.cupomAplicado = null;
    // cartAtual.descontoPerc = 0.0;
    // cartAtual.descontoValor = 0.0;
    var laux = <CartItemModel>[];
    cartAtual.itens = laux.asObservable();
    cartAtual.vlrFrete = 0.0;
  }

  @action
  void setCupomDesconto(CupomDesconto cupom) => cartAtual.cupomAplicado = cupom;

  Future<void> excluiCarrinho() async {
    await _repository.excluiCarrinho(
      userAtualID: _authController.userAtual.firebasebUser.uid,
      cnpjAtivo: _cnpjsController.cnpjAtivo.docId,
    );
    limparCarrinho();
  }
}
