
import 'package:meupedido_core/core/cart/model_mobx/cart.item_model.dart';
import 'package:meupedido_core/models/adicionais/adicional.pedido_model.dart';


class ProdPedidoModel {
  String idProduto;
  int idSistema;
  String descricao;
  double quantidade;
  double vlrUnit;
  double vlrAdics;
  List<AdicionalPedidoModel> adics;

  double get vlrTotal => quantidade * (vlrUnit + vlrAdics);

  ProdPedidoModel({
    this.idProduto,
    this.idSistema,
    this.descricao,
    this.quantidade,
    this.vlrUnit,
    this.vlrAdics,
    this.adics,
  });

  ProdPedidoModel copyWith({
    String idProduto,
    int idSistema,
    String descricao,
    double quantidade,
    double vlrUnit,
    double vlrAdics,
    List<AdicionalPedidoModel> adics,
  }) =>
      ProdPedidoModel(
        idProduto: idProduto ?? this.idProduto,
        idSistema: idSistema ?? this.idSistema,
        descricao: descricao ?? this.descricao,
        quantidade: quantidade ?? this.quantidade,
        vlrUnit: vlrUnit ?? this.vlrUnit,
        vlrAdics: vlrAdics ?? this.vlrAdics,
        adics: adics ?? this.adics,
      );

  factory ProdPedidoModel.fromJson(Map<String, dynamic> json) => ProdPedidoModel(
        idProduto: json["idProduto"] == null ? null : json["idProduto"],
        idSistema: json["idSistema"] == null ? null : json["idSistema"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        quantidade:
            json["quantidade"] == null ? null : json["quantidade"].toDouble(),
        vlrUnit: json["vlrUnit"] == null ? null : json["vlrUnit"].toDouble(),
        vlrAdics: json["vlrAdics"] == null ? null : json["vlrAdics"].toDouble(),
        adics: json["adics"] == null
            ? null
            : List<AdicionalPedidoModel>.from(
                json["adics"].map((x) => AdicionalPedidoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idProduto": idProduto == null ? null : idProduto,
        "idSistema": idSistema == null ? null : idSistema,
        "descricao": descricao == null ? null : descricao,
        "quantidade": quantidade == null ? null : quantidade,
        "vlrUnit": vlrUnit == null ? null : vlrUnit,
        "vlrAdics": vlrAdics == null ? null : vlrAdics,
        "adics": adics == null
            ? null
            : List<dynamic>.from(adics.map((x) => x.toJson())),
      };

  factory ProdPedidoModel.fromCartItem(CartItemModel cart) => ProdPedidoModel(
      idProduto: cart.idProduto,
      idSistema: cart.produto.idSistema,
      descricao: cart.produto.descricao,
      quantidade: cart.quant,
      vlrUnit: cart.produto?.precoAtual ?? 0.00, // unitario
      vlrAdics: cart.vlrAdics ?? 0.00, // unitario
      adics: cart.adics,
    );
}
