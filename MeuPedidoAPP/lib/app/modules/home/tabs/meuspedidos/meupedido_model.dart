// To parse this JSON data, do
//
//     final meuPedido = meuPedidoFromJson(jsonString);

import 'dart:convert';

MeuPedido meuPedidoFromJson(String str) => MeuPedido.fromJson(json.decode(str));

String meuPedidoToJson(MeuPedido data) => json.encode(data.toJson());

class MeuPedido {
    int dataHora;
    String idPedido;
    List<String> prods;
    double totalFinal;

    MeuPedido({
        this.dataHora,
        this.idPedido,
        this.prods,
        this.totalFinal,
    });

    MeuPedido copyWith({
        int dataHora,
        String idPedido,
        List<String> prods,
        double totalFinal,
    }) => 
        MeuPedido(
            dataHora: dataHora ?? this.dataHora,
            idPedido: idPedido ?? this.idPedido,
            prods: prods ?? this.prods,
            totalFinal: totalFinal ?? this.totalFinal,
        );

    factory MeuPedido.fromJson(Map<String, dynamic> json) => MeuPedido(
        dataHora: json["dataHora"] == null ? null : json["dataHora"],
        idPedido: json["idPedido"] == null ? '' : json["idPedido"],
        prods: json["prods"] == null ? [] : List<String>.from(json["prods"].map((x) => x)),
        totalFinal: json["totalFinal"] == null ? 0.00 : json["totalFinal"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "dataHora": dataHora == null ? null : dataHora,
        "idPedido": idPedido == null ? null : idPedido,
        "prods": prods == null ? null : List<dynamic>.from(prods.map((x) => x)),
        "totalFinal": totalFinal == null ? null : totalFinal,
    };
}
