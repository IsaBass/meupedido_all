// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'package:meupedido_core/models/adicionais/adicional.pedido_model.dart';
import 'package:meupedido_core/models/pedido/cupomdesconto_model.dart';
import 'package:mobx/mobx.dart';

import 'cart.item_model.dart';
part 'cart_model.g.dart';

class CartModel = _CartModelBase with _$CartModel;

abstract class _CartModelBase with Store {
  @observable
  String idUser;
  @observable
  CupomDesconto cupomAplicado;
  // @observable
  // double descontoValor = 0.0;
  // @observable
  // double descontoPerc = 0.0;
  @observable
  double vlrFrete = 0.0;
  @observable
  ObservableList<CartItemModel> itens;

  @action
  void adicionarItem(CartItemModel item) {
    //
    var lAux = <AdicionalPedidoModel>[];

    for (var grp in item.produto.grupoAdicionais) {
      for (var adic in grp.adics) {
        if (adic.valor == grp.valorAtual || adic.quantidade > 0.00) {
          lAux.add(AdicionalPedidoModel(
            codigo: adic.codigo,
            descricao: adic.descricao,
            valorUnit: adic.preco,
            quantidade: adic.quantidade ?? 1,
            determinaPreco: grp.determinaPreco
          ));
        }
      }
    }

    //
    item.adics = lAux;
    itens.add(item);
    //
  }

  @action
  void removerItem(CartItemModel item) {
    itens.remove(item);
  }

  @computed
  int get qtdItens => itens?.length ?? 0;

  @computed
  double get valorTotal => valorProdutos - descontoValor + vlrFrete;

  @computed
  double get descontoValor {
    if (cupomAplicado == null || (cupomAplicado.idCupom ?? '').isEmpty)
      return 0.00;
    if ((cupomAplicado.numDesconto ?? 0.00) == 0.0) return 0.00;
    //
    var tot = valorProdutos;
    if(tot <= 0.0) return 0.0;
    if ((cupomAplicado.valorMinimo ?? 0.0) > tot) return 0.00;
    //
    if (cupomAplicado.tipoDesconto == 'PERC') {
      return (tot * (cupomAplicado.numDesconto / 100));
    } else {
      return cupomAplicado.numDesconto;
    }
  }

  @computed
  double get descontoPerc {
    if (cupomAplicado == null || (cupomAplicado.idCupom ?? '').isEmpty)
      return 0.00;
    if ((cupomAplicado.numDesconto ?? 0.00) == 0.0) return 0.00;
    //
    var tot = valorProdutos;
    if ((cupomAplicado.valorMinimo ?? 0.0) > tot) return 0.00;
    //
    if (cupomAplicado.tipoDesconto == 'PERC') {
      return cupomAplicado.numDesconto;
    } else {
      return 0.0;
    }
    ////
  }

  @computed
  double get valorProdutos {
    var tot = 0.00;
    for (var item in itens) {
      tot += item.vlrTot;
    }
    return tot;
  }

  @action
  void setVlrFrete(double vlr) => vlrFrete = vlr; 

  _CartModelBase({
    this.idUser,
    this.cupomAplicado,
    
    this.vlrFrete,
  }) {
    if (itens == null) {
      var laux = <CartItemModel>[];
      itens = laux.asObservable();
    }
  }

  @action
  factory _CartModelBase.fromJson(Map<String, dynamic> json) => CartModel(
        idUser: json["idUser"] == null ? null : json["idUser"],
        // cupomAplicado:
        //     json["cupomAplicado"] == null ? null : json["cupomAplicado"],
        // descontoValor: json["descontoValor"] == null
        //     ? null
        //     : json["descontoValor"].toDouble(),
        // descontoPerc: json["descontoPerc"] == null
        //     ? null
        //     : json["descontoPerc"].toDouble(),
        vlrFrete: json["vlrFrete"] == null ? null : json["vlrFrete"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "idUser": idUser == null ? null : idUser,
        "cupomAplicado": cupomAplicado == null ? null : cupomAplicado.idCupom,
        "descontoValor": descontoValor == null ? null : descontoValor,
        "descontoPerc": descontoPerc == null ? null : descontoPerc,
        "vlrFrete": vlrFrete == null ? null : vlrFrete,
      };
}

//CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

// String cartModelToJson(CartModel data) => json.encode(data.toJson());
