// To parse this JSON data, do
//
//     final pedido = pedidoFromJson(jsonString);

import 'dart:convert';


import 'endereco_model.dart';
import 'pagamento_model.dart';
import 'prodpedido_model.dart';
import 'usuario_model.dart';

Pedido pedidoFromJson(String str) => Pedido.fromJson(json.decode(str));

String pedidoToJson(Pedido data) => json.encode(data.toJson());

class Pedido {
  String docId;
  String codpedido;
  int dataHora;
  String status;
  String idCupomDesc;
  String nomeCupomDesc;
  double totalProdutos;
  double valorDesconto;
  double valorFrete;
  double totalFinal;
  String tipoEntrega;
  String descEntrega;
  List<ProdPedidoModel> prods;
  UsuarioModel usuario;
  EnderecoModel endereco;
  List<PagamentoModel> pagamentos;

  Pedido({
    this.docId,
    this.codpedido,
    this.dataHora,
    this.status,
    this.idCupomDesc,
    this.nomeCupomDesc,
    this.totalProdutos,
    this.valorDesconto,
    this.valorFrete,
    this.totalFinal,
    this.tipoEntrega,
    this.descEntrega,
    this.prods,
    this.usuario,
    this.endereco,
    this.pagamentos,
  }) {
    if (pagamentos == null) pagamentos = <PagamentoModel>[];
     if (prods == null) prods = <ProdPedidoModel>[];
  }

  Pedido copyWith({
    String docId,
    String codpedido,
    int dataHora,
    String status,
    String idCupomDesc,
    String nomeCupomDesc,
    double totalProdutos,
    double valorDesconto,
    double valorFrete,
    double totalFinal,
    String tipoEntrega,
    String descEntrega,
    List<ProdPedidoModel> prods,
    UsuarioModel usuario,
    EnderecoModel endereco,
    List<PagamentoModel> pagamentos,
  }) =>
      Pedido(
        docId: docId ?? this.docId,
        codpedido: codpedido ?? this.codpedido,
        dataHora: dataHora ?? this.dataHora,
        status: status ?? this.status,
        idCupomDesc: idCupomDesc ?? this.idCupomDesc,
        nomeCupomDesc: nomeCupomDesc ?? this.nomeCupomDesc,
        totalProdutos: totalProdutos ?? this.totalProdutos,
        valorDesconto: valorDesconto ?? this.valorDesconto,
        valorFrete: valorFrete ?? this.valorFrete,
        totalFinal: totalFinal ?? this.totalFinal,
        tipoEntrega: tipoEntrega ?? this.tipoEntrega,
        descEntrega: descEntrega ?? this.descEntrega,
        prods: prods ?? this.prods,
        usuario: usuario ?? this.usuario,
        endereco: endereco ?? this.endereco,
        pagamentos: pagamentos ?? this.pagamentos,
      );

  factory Pedido.fromJson(Map<String, dynamic> json) => Pedido(
        docId: json["docId"] == null ? null : json["docId"],
        codpedido: json["CODPEDIDO"] == null ? null : json["CODPEDIDO"],
        dataHora: json["dataHora"] == null ? null : json["dataHora"],
        status: json["status"] == null ? null : json["status"],
        idCupomDesc: json["idCupomDesc"] == null ? null : json["idCupomDesc"],
        nomeCupomDesc:
            json["nomeCupomDesc"] == null ? null : json["nomeCupomDesc"],
        totalProdutos: json["totalProdutos"] == null
            ? null
            : json["totalProdutos"].toDouble(),
        valorDesconto: json["valorDesconto"] == null
            ? null
            : json["valorDesconto"].toDouble(),
        valorFrete:
            json["valorFrete"] == null ? null : json["valorFrete"].toDouble(),
        totalFinal:
            json["totalFinal"] == null ? null : json["totalFinal"].toDouble(),
        tipoEntrega: json["tipoEntrega"] == null ? null : json["tipoEntrega"],
        descEntrega: json["descEntrega"] == null ? null : json["descEntrega"],
        prods: json["prods"] == null
            ? null
            : List<ProdPedidoModel>.from(
                json["prods"].map((x) => ProdPedidoModel.fromJson(x))),
        usuario: json["usuario"] == null
            ? null
            : UsuarioModel.fromJson(json["usuario"]),
        endereco: json["endereco"] == null
            ? null
            : EnderecoModel.fromJson(json["endereco"]),
        pagamentos: json["pagamentos"] == null
            ? null
            : List<PagamentoModel>.from(
                json["pagamentos"].map((x) => PagamentoModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "docId": docId == null ? null : docId,
        "CODPEDIDO": codpedido == null ? null : codpedido,
        "dataHora": dataHora == null ? null : dataHora,
        "status": status == null ? null : status,
        "idCupomDesc": idCupomDesc == null ? null : idCupomDesc,
        "nomeCupomDesc": nomeCupomDesc == null ? null : nomeCupomDesc,
        "totalProdutos": totalProdutos == null ? null : totalProdutos,
        "valorDesconto": valorDesconto == null ? null : valorDesconto,
        "valorFrete": valorFrete == null ? null : valorFrete,
        "totalFinal": totalFinal == null ? null : totalFinal,
        "tipoEntrega": tipoEntrega == null ? null : tipoEntrega,
        "descEntrega": descEntrega == null ? null : descEntrega,
        "prods": prods == null
            ? <ProdPedidoModel>[]
            : List<dynamic>.from(prods.map((x) => x.toJson())),
        "usuario": usuario == null ? null : usuario.toJson(),
        "endereco": endereco == null ? null : endereco.toJson(),
        "pagamentos": pagamentos == null
            ? <PagamentoModel>[]
            : List<dynamic>.from(pagamentos.map((x) => x.toJson())),
      };
}
