/*
{
  "codCateg": 5,
  "descricao": "qualquer coisa",
  "img" : "url da imagem",
  "imgTipo": "EXT/INTERNO",
  "icone" : "string aqui",
  "logoPeq" : "asdaddadda",
  "tipoLogoPeq" : "interno/externo"
}
*/

// To parse this JSON data, do
//
//     final categoriaModel = categoriaModelFromJson(jsonString);

import 'dart:convert';

import 'package:meupedido_core/meupedido_core.dart';

CategoriaModel categoriaModelFromJson(String str) =>
    CategoriaModel.fromJson(json.decode(str));

String categoriaModelToJson(CategoriaModel data) => json.encode(data.toJson());

class CategoriaModel {
  //DocumentReference docRef;
  String docId;
  int codCateg;
  String descricao;
  bool ativo;
  String img;
  String imgTipo;
  String icone;
  String logoPeq;
  String tipoLogoPeq;
  List<AdicionalGrpModel> grupoAdicionais;
  List<ProdutoModel> destaques;

  CategoriaModel(
      {this.docId,
      this.codCateg,
      this.descricao,
      this.ativo = true,
      this.img,
      this.imgTipo,
      this.icone = '06',
      this.logoPeq,
      this.tipoLogoPeq,
      this.grupoAdicionais,
      this.destaques}) {
    if (grupoAdicionais == null) grupoAdicionais = [];
    if (destaques == null) destaques = [];
  }

  factory CategoriaModel.fromJson(Map<String, dynamic> json) => CategoriaModel(
        docId: json["docId"] == null ? null : json["docId"],
        codCateg: json["codCateg"] == null ? null : json["codCateg"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        ativo: json["ativo"] == null ? true : json["ativo"],
        img: json["img"] == null ? null : json["img"],
        imgTipo: json["imgTipo"] == null ? null : json["imgTipo"],
        icone: json["icone"] == null ? null : json["icone"],
        logoPeq: json["logoPeq"] == null ? null : json["logoPeq"],
        tipoLogoPeq: json["tipoLogoPeq"] == null ? null : json["tipoLogoPeq"],
      );

  // factory CategoriaModel.fromDocumentSnapshot(DocumentSnapshot doc) {
  //   var categ = CategoriaModel.fromJson(doc.data);
  //   categ.docRef = doc.reference;

  //   return categ;
  // }

  Map<String, dynamic> toJson() => {
        "codCateg": codCateg == null ? null : codCateg,
        "descricao": descricao == null ? null : descricao,
        "ativo": ativo == null ? true : ativo,
        "img": img == null ? null : img,
        "imgTipo": imgTipo == null ? null : imgTipo,
        "icone": icone == null ? null : icone,
        "logoPeq": logoPeq == null ? null : logoPeq,
        "tipoLogoPeq": tipoLogoPeq == null ? null : tipoLogoPeq,
      };
}
