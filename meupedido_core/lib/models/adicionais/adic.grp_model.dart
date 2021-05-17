// To parse this JSON data, do
//
//     final adicionalGrpModel = adicionalGrpModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

import 'adicional_model.dart';

AdicionalGrpModel adicionalGrpModelFromJson(String str) =>
    AdicionalGrpModel.fromJson(json.decode(str));

String adicionalGrpModelToJson(AdicionalGrpModel data) =>
    json.encode(data.toJson());

class AdicionalGrpModel {
  int codGrupo;
  String docId;
  String descricao;
  // String tipoEscolha; // C = CHECK , U = UNICO , Q = QUANTIDADE
  int ordem;
  int maxQtd;
  int minQtd;
  bool determinaPreco;
  String valorAtual;
  String origem; // "C" = da categ ... "P" = do produto
  String idOrigem; // id da Categ ou do Produto
  List<AdicionalModel> adics;

  AdicionalGrpModel(
      {this.codGrupo,
      this.docId,
      this.descricao,
      // this.tipoEscolha = 'C',
      this.ordem,
      this.valorAtual = '',
      this.adics,
      this.determinaPreco,
      this.origem,
      this.idOrigem,
      @required this.maxQtd,
      @required this.minQtd}) {
    if (adics == null) adics = [];
  }

  AdicionalGrpModel.newModel(AdicionalGrpModel orig) {
    codGrupo = orig.codGrupo;
    docId = orig.docId;
    descricao = orig.descricao;
    // tipoEscolha = orig.tipoEscolha;
    ordem = orig.ordem;
    valorAtual = orig.valorAtual;
    adics = orig.adics.map((e) => AdicionalModel.newModel(e)).toList();
    maxQtd = orig.maxQtd;
    minQtd = orig.minQtd;
    origem = orig.origem;
    idOrigem = orig.idOrigem;
    determinaPreco = orig.determinaPreco;
  }

  AdicionalGrpModel.modelZero(AdicionalGrpModel orig) {
    codGrupo = orig.codGrupo;
    docId = orig.docId;
    descricao = orig.descricao;
    // tipoEscolha = orig.tipoEscolha;
    ordem = orig.ordem;
    valorAtual = '';
    adics = orig.adics.map((e) => AdicionalModel.modelZero(e)).toList();
    maxQtd = orig.maxQtd;
    minQtd = orig.minQtd;
    origem = orig.origem;
    idOrigem = orig.idOrigem;
    determinaPreco = orig.determinaPreco;
  }

  int get qtdSelecionada {
    if (minQtd == 1 && minQtd == maxQtd && valorAtual != '') {
      return 1;
    }

    var qtd = 0.00;
    for (var adic in adics) {
      qtd += adic.quantidade;
    }
    return qtd.round();
  }

  bool get validado {
    //var b = true;
    if (minQtd > 0 && qtdSelecionada < minQtd) return false;
    //if (maxQtd > 0 && qtdSelecionada >= maxQtd) return true;
    return true;
  }

  factory AdicionalGrpModel.fromJson(Map<String, dynamic> json) =>
      AdicionalGrpModel(
        codGrupo: json["codGrupo"] == null ? null : json["codGrupo"],
        docId: json["docId"] == null ? null : json["docId"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        // tipoEscolha: json["tipoEscolha"] == null ? null : json["tipoEscolha"],
        ordem: json["ordem"] == null ? null : json["ordem"],
        valorAtual: json["valorAtual"] == null ? null : json["valorAtual"],
        minQtd: json["minQtd"] == null ? 0 : json["minQtd"],
        maxQtd: json["maxQtd"] == null ? 0 : json["maxQtd"],
        origem: json["origem"] == null ? null : json["origem"],
        idOrigem: json["idOrigem"] == null ? null : json["idOrigem"],
        determinaPreco:
            json["determinaPreco"] == null ? false : json["determinaPreco"],
        adics: json["adics"] == null
            ? <AdicionalModel>[]
            : (json["adics"] as List)
                .map((e) => AdicionalModel.fromJson(e))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        "docId": docId == null ? null : docId,
        "codGrupo": codGrupo == null ? null : codGrupo,
        "descricao": descricao == null ? null : descricao,
        // "multiplos": tipoEscolha == null ? null : tipoEscolha,
        "ordem": ordem == null ? null : ordem,
        "valorAtual": valorAtual == null ? null : valorAtual,
        "maxQtd": maxQtd == null ? 0 : maxQtd,
        "minQtd": minQtd == null ? 0 : minQtd,
        "determinaPreco": determinaPreco == null ? false : determinaPreco
      };
}
