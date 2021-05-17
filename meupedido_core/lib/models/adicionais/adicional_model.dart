/*
{
  "codigo": 5,
  "descricao": "qualquer coisa",
  "valor" : "CODAQUI",
  "preco": 59.90
}
*/

// To parse this JSON data, do
//
//     final adicionalModel = adicionalModelFromJson(jsonString);

import 'dart:convert';

AdicionalModel adicionalModelFromJson(String str) =>
    AdicionalModel.fromJson(json.decode(str));

String adicionalModelToJson(AdicionalModel data) => json.encode(data.toJson());

class AdicionalModel {
  int codigo;
  String descricao;
  String valor;
  double preco;
  double quantidade;
  bool checked;

  AdicionalModel(
      {this.codigo,
      this.descricao,
      this.valor,
      this.preco = 0.0,
      this.quantidade = 0.0,
      this.checked = false});

  AdicionalModel.newModel(AdicionalModel orig) {
    codigo = orig.codigo;
    descricao = orig.descricao;
    valor = orig.valor;
    preco = orig.preco;
    quantidade = orig.quantidade;
    checked = orig.checked;
  }
  AdicionalModel.modelZero(AdicionalModel orig) {
    codigo = orig.codigo;
    descricao = orig.descricao;
    valor = orig.valor;
    preco = orig.preco;
    quantidade = 0;
    checked = false;
  }

  factory AdicionalModel.fromJson(Map<String, dynamic> json) => AdicionalModel(
        codigo: json["codigo"] == null ? null : json["codigo"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        valor: json["valor"] == null ? null : json["valor"],
        preco: json["preco"] == null ? null : json["preco"].toDouble(),
        quantidade:
            json["quantidade"] == null ? 0 : json["quantidade"].toDouble(),
        checked: json["checked"] == null ? false : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo == null ? null : codigo,
        "descricao": descricao == null ? null : descricao,
        "valor": valor == null ? null : valor,
        "preco": preco == null ? null : preco,
        "checked": checked == null ? false : checked,
      };
}
