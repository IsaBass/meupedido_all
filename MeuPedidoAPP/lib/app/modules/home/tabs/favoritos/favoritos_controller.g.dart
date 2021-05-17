// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favoritos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FavoritosController on _FavoritosBase, Store {
  final _$favsAtom = Atom(name: '_FavoritosBase.favs');

  @override
  ObservableList<ProdutoModel> get favs {
    _$favsAtom.reportRead();
    return super.favs;
  }

  @override
  set favs(ObservableList<ProdutoModel> value) {
    _$favsAtom.reportWrite(value, super.favs, () {
      super.favs = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_FavoritosBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getProdutoFavAsyncAction =
      AsyncAction('_FavoritosBase.getProdutoFav');

  @override
  Future<void> getProdutoFav() {
    return _$getProdutoFavAsyncAction.run(() => super.getProdutoFav());
  }

  final _$_FavoritosBaseActionController =
      ActionController(name: '_FavoritosBase');

  @override
  void excluirFavorito(ProdutoModel prod) {
    final _$actionInfo = _$_FavoritosBaseActionController.startAction(
        name: '_FavoritosBase.excluirFavorito');
    try {
      return super.excluirFavorito(prod);
    } finally {
      _$_FavoritosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
favs: ${favs},
isLoading: ${isLoading}
    ''';
  }
}
