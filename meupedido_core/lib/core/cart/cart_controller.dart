import 'package:meupedido_core/models/pedido/cupomdesconto_model.dart';
import 'package:meupedido_core/models/produto_model.dart';
import 'package:mobx/mobx.dart';

import 'cart_repository_interf.dart';
import 'model_mobx/cart.item_model.dart';
import 'model_mobx/cart_model.dart';

part 'cart_controller.g.dart';

class CartController = _CartBase with _$CartController;

abstract class _CartBase with Store {
  //
  final ICartRepository _repository;
  //

  @observable
  CartModel cartAtual;

  String _uid = "";
  String _cnpj = "";

  void setVariables(String uid, String cnpj) {
    this._uid = uid;
    this._cnpj = cnpj;
  }

  void clearVariables() {
    this._uid = "";
    this._cnpj = "";
  }

  _CartBase(this._repository) {
    cartAtual = CartModel();
  }

  @action
  Future<void> adicionarCarrinho(CartItemModel item) async {
    if (_uid == "" || _cnpj == "") return;
    ////
    cartAtual.adicionarItem(item);
    item.docId = await _repository.addCarrinho(
      item.toJson(),
      userAtualID: _uid,
      cnpjAtivo: _cnpj,
    );
    //
  }

  @action
  void removeCarrinho(
      //DocumentReference userDocRef,
      CartItemModel item) {
    if (_uid == "" || _cnpj == "") return;
    //
    // _uid
    // _cnpj

    if (item.docId.isNotEmpty) {
      _repository.removeCarrinho(
        item.docId,
        userAtualID: _uid,
        cnpjAtivo: _cnpj,
      );
    }
    cartAtual.removerItem(item);
  }

  @action
  Future<void> incrementItem(CartItemModel item) async {
    if (_uid == "" || _cnpj == "") return;
    //
    item.incrementQtd();

    if (item.docId.isEmpty) {
      item.docId = await _repository.addCarrinho(
        item.toJson(),
        userAtualID: _uid,
        cnpjAtivo: _cnpj,
        // cnpjAtivoDocRef: _cnpjsController.cnpjAtivo.docRef,
        // userAtualDocRef: _authController.userAtual.docRef,
      );
    } else {
      _repository.updItemCarrinho(
        item.docId,
        item.toJson(),
        _cnpj,
        _uid,
      );
    }
  }

  @action
  Future<void> decrementItem(CartItemModel item) async {
    if (_uid == "" || _cnpj == "") return;
    //
    item.decrementQtd();

    if (item.docId.isEmpty) {
      item.docId = await _repository.addCarrinho(
          // userDocRef,
          item.toJson(),
          userAtualID: _uid,
          cnpjAtivo: _cnpj
          // cnpjAtivoDocRef: _cnpjsController.cnpjAtivo.docRef,
          // userAtualDocRef: _authController.userAtual.docRef,
          );
    } else {
      _repository.updItemCarrinho(
        item.docId,
        item.toJson(),
        _cnpj,
        _uid,

        // _authController.userAtual.docRef,
        // _cnpjsController.cnpjAtivo.docRef,
      );
    }
  }

  @action
  Future<void> carregaCarrinhoUser() async {
    if (_uid == "" || _cnpj == "") return;
    /////
    limparCarrinho();
    var query = await _repository.getCarrinho(
      userAtualID: _uid,
      cnpjAtivo: _cnpj,
    );

    if (query == null) {
      return;
    }
    for (var doc in query) {
      var item = await cartItemModelfromJson(doc);
      var docP = await _repository.getProduto(_cnpj, item.idProduto);
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
    if (_uid == "" || _cnpj == "") return;

    await _repository.excluiCarrinho(
      userAtualID: _uid,
      cnpjAtivo: _cnpj,
    );
    limparCarrinho();
  }
}
