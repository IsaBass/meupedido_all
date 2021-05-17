import 'package:meupedido_core/models/adicionais/adicional.pedido_model.dart';
import 'package:meupedido_core/models/produto_model.dart';
import 'package:mobx/mobx.dart';

part 'cart.item_model.g.dart';

// CartItemModel cartItemModelFromJson(String str) =>
//     CartItemModel.fromJson(json.decode(str));

// String cartItemModelToJson(CartItemModel data) => json.encode(data.toJson());
Future<CartItemModel> cartItemModelfromJson(Map<String, dynamic> json) async {
  //
  var adicsAux = <AdicionalPedidoModel>[];
  //
  if (json['adics'] != null) {
    json['adics'].forEach((v) {
      ///
      var adic = AdicionalPedidoModel.fromJson(v);
      // if (adic.determinaPreco) {
      //   // PEGAR PRECO ATUAL DO ESCOLHIDO
      //   //var preco = await _getPrecoAdicional(adic.idGrpAdic, adic.codigo, json["idProduto"]);
      //   //adic.valorUnit = preco;
      // }
      adicsAux.add(adic);
      ////
    });
  }
  //
  return CartItemModel(
    idProduto: json["idProduto"] == null ? '' : json["idProduto"],
    docId: json["docId"] == null ? '' : json["docId"],
    quant: json["quant"] == null ? 0.00 : json["quant"].toDouble(),
    // vlrUnit: json["vlrUnit"] == null ? 0.00 : json["vlrUnit"].toDouble(),
    adics: adicsAux,
  );
  //
}

class CartItemModel = _CartItemModelBase with _$CartItemModel;

abstract class _CartItemModelBase with Store {
  //
  String idProduto;

  @observable
  double quant;

  // esse é apenas informativo do primeiro preco unitario qndo adicionou
  //double vlrUnit;
  ProdutoModel produto;
  String docId;
  List<AdicionalPedidoModel> adics;

  @action
  void incrementQtd() {
    quant++;
  }

  @action
  void decrementQtd() {
    if (quant >= 1) quant--;
  }

  @computed
  double get vlrTot {
    var tot = 0.00;
    // aqui já com adicionais qnd produto ainda tem as List de AdicionaisModel
    tot += (quant * produto.valorTotal);
    //
    //// aqui  adicionais qnd so tem adics trazido da base: AdicionalPedidoModel
    if ((produto.grupoAdicionais?.length ?? 0) == 0 ) tot += vlrAdics * quant;
    //
    return tot;
  }

  @computed
  double get vlrAdics {
    var tot = 0.00;
    //// aqui  adicionais qnd so tem adics trazido da base: AdicionalPedidoModel
    if (adics != null) {
      for (var adic in adics) {
        if (!(adic.determinaPreco ?? false))
          tot +=
              ((adic.quantidade == 0 ? 1 : adic.quantidade) * adic.valorUnit);
      }
    }
    //
    return tot;
  }

  _CartItemModelBase(
      {this.idProduto,
      this.quant,
      // this.vlrUnit,
      this.produto,
      this.docId = '',
      this.adics});

  Map<String, dynamic> toJson() {
    return {
      "idProduto": idProduto == null ? '' : idProduto,
      "quant": quant == null ? 0.00 : quant,
      // "vlrUnit": vlrUnit == null ? 0.00 : vlrUnit,
      "adics": adics != null ? adics.map((v) => v.toJson()).toList() : null,
    };
  }
}

// Future<double> _getPrecoAdicional(String idGrp, int codigo, String idProduto) {
//   //
//   // AppModule.to.get<AppController>().cnpjAtivoDocRef
//   // .collection('produtos')
//   //
// }
