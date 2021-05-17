/* {
  "idSistema": 5,
  "codigo": "000005",
  "precoAtual" : 59.90,
  "precoDe": 89.90,
  "img" : "url da imagem",
  "imgTipo": "EXT/INTERNO",
  "codCateg": 2,
  "codSecao": 5,
  "buscouAdics": false,
  "destaqueCateg" : true,
  "destaqueGeral" : false,
  "emPromocao" : true
}
*/
// To parse this JSON data, do
//
//     final produtoModel = produtoModelFromJson(jsonString);

import 'dart:convert';

import 'adicionais/adic.grp_model.dart';

ProdutoModel produtoModelFromJson(String str) =>
    ProdutoModel.fromJson(json.decode(str));

String produtoModelToJson(ProdutoModel data) => json.encode(data.toJson());

class ProdutoModel {
  int idSistema;
  String codigo;
  String descricao;
  String descritivo;
  double precoAtual;
  double precoDe;
  String img;
  String imgTipo;
  int codCateg;
  int codSecao;
  bool buscouAdics;
  bool destaqueCateg;
  bool destaqueGeral;
  bool emPromocao;
  bool ativo;
  List<AdicionalGrpModel> grupoAdicionais;

  ProdutoModel(
      {this.idSistema,
      this.codigo,
      this.descricao,
      this.descritivo,
      this.precoAtual,
      this.precoDe,
      this.img,
      this.imgTipo,
      this.codCateg,
      this.codSecao,
      this.buscouAdics,
      this.destaqueCateg,
      this.destaqueGeral,
      this.emPromocao,
      this.ativo,
      this.grupoAdicionais}) {
    if (grupoAdicionais == null) grupoAdicionais = [];
  }

  ProdutoModel.modelZero(ProdutoModel prod) {
    idSistema = prod.idSistema;
    codigo = prod.codigo;
    descricao = prod.descricao;
    descritivo = prod.descritivo;
    precoAtual = prod.precoAtual;
    precoDe = prod.precoDe;
    img = prod.img;
    imgTipo = prod.imgTipo;
    codCateg = prod.codCateg;
    codSecao = prod.codSecao;
    buscouAdics = prod.buscouAdics;
    destaqueCateg = prod.destaqueCateg;
    destaqueGeral = prod.destaqueGeral;
    emPromocao = prod.emPromocao;
    ativo = prod.ativo;
    grupoAdicionais = prod.grupoAdicionais
        .map((e) => AdicionalGrpModel.modelZero(e))
        .toList();

    if (grupoAdicionais == null) grupoAdicionais = [];
  }

  factory ProdutoModel.fromJson(Map<String, dynamic> json) => ProdutoModel(
        idSistema: json["idSistema"] == null ? null : json["idSistema"],
        codigo: json["docId"] == null ? null : json["docId"],
        ativo: json["ativo"] == null ? true : json["ativo"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        descritivo: json["descritivo"] == null ? null : json["descritivo"],
        precoAtual:
            json["precoAtual"] == null ? null : json["precoAtual"].toDouble(),
        precoDe: json["precoDe"] == null ? null : json["precoDe"].toDouble(),
        img: json["img"] == null ? null : json["img"],
        imgTipo: json["imgTipo"] == null ? null : json["imgTipo"],
        codCateg: json["codCateg"] == null ? null : json["codCateg"],
        codSecao: json["codSecao"] == null ? null : json["codSecao"],
        buscouAdics: json["buscouAdics"] == null ? null : json["buscouAdics"],
        destaqueCateg:
            json["destaqueCateg"] == null ? null : json["destaqueCateg"],
        destaqueGeral:
            json["destaqueGeral"] == null ? null : json["destaqueGeral"],
        emPromocao: json["emPromocao"] == null ? null : json["emPromocao"],
      );

  Map<String, dynamic> toJson() => {
        "idSistema": idSistema == null ? null : idSistema,
        "codigo": codigo == null ? null : codigo,
        "descricao": descricao == null ? '' : descricao,
        "descritivo": descritivo == null ? '' : descritivo,
        "precoAtual": precoAtual == null ? null : precoAtual,
        "precoDe": precoDe == null ? null : precoDe,
        "img": img == null ? null : img,
        "imgTipo": imgTipo == null ? null : imgTipo,
        "codCateg": codCateg == null ? null : codCateg,
        "codSecao": codSecao == null ? null : codSecao,
        "buscouAdics": buscouAdics == null ? null : buscouAdics,
        "destaqueCateg": destaqueCateg == null ? null : destaqueCateg,
        "destaqueGeral": destaqueGeral == null ? null : destaqueGeral,
        "emPromocao": emPromocao == null ? null : emPromocao,
        "ativo": ativo == null ? true : ativo,
      };

  //
  double get valorTotal =>  precoAtual + valorAdics;
  //
  double get valorAdics {
    var tot = 0.00;
    for (var grp in grupoAdicionais) {
      for (var adic in grp.adics) {
        if (!grp.determinaPreco) {
          if (adic.valor == grp.valorAtual) {
            // verifica se de escolha unica
            tot += (adic.preco ?? 0.00);
          } else {
            if (adic.quantidade > 0.00) {
              tot += (adic.quantidade * (adic.preco ?? 0.00));
            }
          }
        // } else {
        //   if (adic.valor == grp.valorAtual) { // preco do determinante
        //     precoAtual = (adic.preco ?? 0.00);
        //   }
        }
      }
    }
    return tot ;
  }

  bool get adicionaisValidados {
    for (var grp in grupoAdicionais) {
      if (grp.validado == false) return false;
    }

    return true;
  }
}
