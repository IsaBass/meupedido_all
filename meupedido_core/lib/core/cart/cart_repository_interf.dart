import 'package:flutter/foundation.dart';

abstract class ICartRepository {
  //
  //
  Future<String> addCarrinho(Map data,
      {@required String cnpjAtivo, @required String userAtualID});
  //
  void removeCarrinho(
    String idCart, {
    @required String cnpjAtivo,
    @required String userAtualID,
  });
  //
  Future<void> updItemCarrinho(
    String idCart,
    Map data,
    String cnpjAtivo,
    String userAtualID,
  );
  //
  Future<List<Map>> getCarrinho({
    @required String cnpjAtivo,
    @required String userAtualID,
  });
  //
  Future<void> excluiCarrinho({
    @required String cnpjAtivo,
    @required String userAtualID,
  });
  //
  Future<Map<String, dynamic>> getProduto(String cnpjAtivo, String idProduto);
  //
}
