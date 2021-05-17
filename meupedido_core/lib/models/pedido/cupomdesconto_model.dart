// To parse this JSON data, do
//
//     final cupomDesconto = cupomDescontoFromJson(jsonString);

import 'dart:convert';

CupomDesconto cupomDescontoFromJson(String str) => CupomDesconto.fromMap(json.decode(str));

String cupomDescontoToJson(CupomDesconto data) => json.encode(data.toMap());

class CupomDesconto {
    String idCupom;
    String tagCupom;
    int qtdMax;
    int qtdVendido;
    double valorMinimo;
    String tipoDesconto;
    double numDesconto;
    int dtHoraInicio;
    int dtHoraFim;

    CupomDesconto({
        this.idCupom,
        this.tagCupom,
        this.qtdMax,
        this.qtdVendido,
        this.valorMinimo,
        this.tipoDesconto,
        this.numDesconto,
        this.dtHoraInicio,
        this.dtHoraFim,
    });

    CupomDesconto copyWith({
        String idCupom,
        String tagCupom,
        int qtdMax,
        int qtdVendido,
        double valorMinimo,
        String tipoDesconto,
        double numDesconto,
        int dtHoraInicio,
        int dtHoraFim,
    }) => 
        CupomDesconto(
            idCupom: idCupom ?? this.idCupom,
            tagCupom: tagCupom ?? this.tagCupom,
            qtdMax: qtdMax ?? this.qtdMax,
            qtdVendido: qtdVendido ?? this.qtdVendido,
            valorMinimo: valorMinimo ?? this.valorMinimo,
            tipoDesconto: tipoDesconto ?? this.tipoDesconto,
            numDesconto: numDesconto ?? this.numDesconto,
            dtHoraInicio: dtHoraInicio ?? this.dtHoraInicio,
            dtHoraFim: dtHoraFim ?? this.dtHoraFim,
        );

    factory CupomDesconto.fromMap(Map<String, dynamic> json) => CupomDesconto(
        idCupom: json["idCupom"] == null ? '' : json["idCupom"],
        tagCupom: json["tagCupom"] == null ? '' : json["tagCupom"],
        qtdMax: json["qtdMax"] == null ? 0 : json["qtdMax"],
        qtdVendido: json["qtdVendido"] == null ? 0 : json["qtdVendido"],
        valorMinimo: json["valorMinimo"] == null ? 0.00 : json["valorMinimo"].toDouble(),
        tipoDesconto: json["tipoDesconto"] == null ? '' : json["tipoDesconto"],
        numDesconto: json["numDesconto"] == null ? 0.00 : json["numDesconto"].toDouble(),
        dtHoraInicio: json["dtHoraInicio"] == null ? null : json["dtHoraInicio"],
        dtHoraFim: json["dtHoraFim"] == null ? null : json["dtHoraFim"],
    );

    Map<String, dynamic> toMap() => {
        "idCupom": idCupom == null ? '' : idCupom,
        "tagCupom": tagCupom == null ? '' : tagCupom,
        "qtdMax": qtdMax == null ? 0 : qtdMax,
        "qtdVendido": qtdVendido == null ? 0 : qtdVendido,
        "valorMinimo": valorMinimo == null ? 0.0 : valorMinimo,
        "tipoDesconto": tipoDesconto == null ? '' : tipoDesconto,
        "numDesconto": numDesconto == null ? 0.00 : numDesconto,
        "dtHoraInicio": dtHoraInicio == null ? null : dtHoraInicio,
        "dtHoraFim": dtHoraFim == null ? null : dtHoraFim,
    };
}


/*
{
  "idCupom": "jsjcscnsnc",
  "tagCupom" : "OFF10",
  "qtdMax": 10,
  "qtdVendido" : 2,
  "valorMinimo": 12.25,
  "tipoDesconto": "PERC/VALOR",
  "numDesconto": 10.35,
  "dtHoraInicio" : 4444494949,
  "dtHoraFim": 48484848
 }
*/