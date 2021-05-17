// To parse this JSON data, do
//
//     final cnpjConfigsModel = cnpjConfigsModelFromJson(jsonString);

import 'dart:convert';

CnpjConfigsModel cnpjConfigsModelFromJson(String str) =>
    CnpjConfigsModel.fromJson(json.decode(str));

String cnpjConfigsModelToJson(CnpjConfigsModel data) =>
    json.encode(data.toJson());

class CnpjConfigsModel {
  double freteBase;
  String complemEndereco;
  String mecanismoCartao;
  double freteKmBase;
  String logradouro;
  String numEndereco;
  String email;
  String cep;
  double freteKm;
  double coordLong;
  String foneContato;
  int parcSemJuros;
  double coordLat;
  String cieloMerchanId;
  String cieloMerchanKey;
  String nomeFaturaCartao;

  CnpjConfigsModel({
    this.freteBase,
    this.complemEndereco,
    this.mecanismoCartao,
    this.freteKmBase,
    this.logradouro,
    this.numEndereco,
    this.email,
    this.cep,
    this.freteKm,
    this.coordLong,
    this.foneContato,
    this.parcSemJuros,
    this.coordLat,
    this.cieloMerchanId,
    this.cieloMerchanKey,
    this.nomeFaturaCartao,
  });

  factory CnpjConfigsModel.fromJson(Map<String, dynamic> json) =>
      CnpjConfigsModel(
        freteBase:
            json["freteBase"] == null ? null : json["freteBase"].toDouble(),
        complemEndereco:
            json["complemEndereco"] == null ? null : json["complemEndereco"],
        mecanismoCartao:
            json["mecanismoCartao"] == null ? null : json["mecanismoCartao"],
        freteKmBase:
            json["freteKmBase"] == null ? null : json["freteKmBase"].toDouble(),
        logradouro: json["logradouro"] == null ? null : json["logradouro"],
        numEndereco: json["numEndereco"] == null ? null : json["numEndereco"],
        email: json["email"] == null ? null : json["email"],
        cep: json["CEP"] == null ? null : json["CEP"],
        freteKm: json["freteKm"] == null ? null : json["freteKm"].toDouble(),
        foneContato: json["foneContato"] == null ? null : json["foneContato"],
        parcSemJuros:
            json["parcSemJuros"] == null ? null : json["parcSemJuros"],
        coordLong:
            json["coordLong"] == null ? null : json["coordLong"].toDouble(),
        coordLat: json["coordLat"] == null ? null : json["coordLat"].toDouble(),
        cieloMerchanId:
            json["cieloMerchanId"] == null ? null : json["cieloMerchanId"],
        cieloMerchanKey:
            json["cieloMerchanKey"] == null ? null : json["cieloMerchanKey"],
        nomeFaturaCartao:
            json["nomeFaturaCartao"] == null ? null : json["nomeFaturaCartao"],
      );

  Map<String, dynamic> toJson() => {
        "freteBase": freteBase == null ? null : freteBase,
        "complemEndereco": complemEndereco == null ? null : complemEndereco,
        "mecanismoCartao": mecanismoCartao == null ? null : mecanismoCartao,
        "freteKmBase": freteKmBase == null ? null : freteKmBase,
        "logradouro": logradouro == null ? null : logradouro,
        "numEndereco": numEndereco == null ? null : numEndereco,
        "email": email == null ? null : email,
        "CEP": cep == null ? null : cep,
        "freteKm": freteKm == null ? null : freteKm,
        "coordLong": coordLong == null ? null : coordLong,
        "foneContato": foneContato == null ? null : foneContato,
        "parcSemJuros": parcSemJuros == null ? null : parcSemJuros,
        "coordLat": coordLat == null ? null : coordLat,
      };
}
