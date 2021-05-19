// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartController on _CartBase, Store {
  final _$cartAtualAtom = Atom(name: '_CartBase.cartAtual');

  @override
  CartModel get cartAtual {
    _$cartAtualAtom.reportRead();
    return super.cartAtual;
  }

  @override
  set cartAtual(CartModel value) {
    _$cartAtualAtom.reportWrite(value, super.cartAtual, () {
      super.cartAtual = value;
    });
  }

  final _$adicionarCarrinhoAsyncAction =
      AsyncAction('_CartBase.adicionarCarrinho');

  @override
  Future<void> adicionarCarrinho(CartItemModel item) {
    return _$adicionarCarrinhoAsyncAction
        .run(() => super.adicionarCarrinho(item));
  }

  final _$incrementItemAsyncAction = AsyncAction('_CartBase.incrementItem');

  @override
  Future<void> incrementItem(CartItemModel item) {
    return _$incrementItemAsyncAction.run(() => super.incrementItem(item));
  }

  final _$decrementItemAsyncAction = AsyncAction('_CartBase.decrementItem');

  @override
  Future<void> decrementItem(CartItemModel item) {
    return _$decrementItemAsyncAction.run(() => super.decrementItem(item));
  }

  final _$carregaCarrinhoUserAsyncAction =
      AsyncAction('_CartBase.carregaCarrinhoUser');

  @override
  Future<void> carregaCarrinhoUser() {
    return _$carregaCarrinhoUserAsyncAction
        .run(() => super.carregaCarrinhoUser());
  }

  final _$_CartBaseActionController = ActionController(name: '_CartBase');

  @override
  void removeCarrinho(CartItemModel item) {
    final _$actionInfo = _$_CartBaseActionController.startAction(
        name: '_CartBase.removeCarrinho');
    try {
      return super.removeCarrinho(item);
    } finally {
      _$_CartBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void limparCarrinho() {
    final _$actionInfo = _$_CartBaseActionController.startAction(
        name: '_CartBase.limparCarrinho');
    try {
      return super.limparCarrinho();
    } finally {
      _$_CartBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCupomDesconto(CupomDesconto cupom) {
    final _$actionInfo = _$_CartBaseActionController.startAction(
        name: '_CartBase.setCupomDesconto');
    try {
      return super.setCupomDesconto(cupom);
    } finally {
      _$_CartBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cartAtual: ${cartAtual}
    ''';
  }
}
