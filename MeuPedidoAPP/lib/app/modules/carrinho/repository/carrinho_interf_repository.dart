abstract class ICarrinhoRepository {
  //
  Future<String> gravarPedido(Map pedido);
  Future<String> gravarPedidoTemporario();
  Future<void> excluiPedidoTemporario(String idPedido);
  //
  Future<List<Map>> getEnderecos();
  Future<void> excluiEndereco(String id);
  //
  Future<Map> getCupomDesconto(String tagCupom);
}
