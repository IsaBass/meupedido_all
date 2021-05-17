
abstract class IPedidoRepository {
  //
  Stream<Map<String, dynamic>> getPedido(String idPedido);
  //
  void cancelePedido(
    String idPedido,
    String motivo,
    String statusAtual,
  );
  //
  void cancelePendentePedido(
    String idPedido,
    String motivo,
    String statusAtual,
  );
}
