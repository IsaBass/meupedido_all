class PagamentoModel {
  String codPag;
  String tipo;
  String forma;
  String descricao;
  double valor;
  String bandeira;
  String codAutorizacao;
  String numNSU;
  String finalCartao;
  String mecanismoCartao;
  String idVendaCartao;
  double trocoPara;
  int parcelas;

  PagamentoModel({
    this.codPag,
    this.tipo,
    this.descricao,
    this.valor,
    this.bandeira,
    this.codAutorizacao,
    this.trocoPara,
    this.forma,
    this.numNSU,
    this.finalCartao,
    this.mecanismoCartao,
    this.idVendaCartao,
    this.parcelas
  });

  PagamentoModel copyWith({
    String codPag,
    String tipo,
    String descricao,
    double valor,
    String bandeira,
    String codAutorizacao,
    double trocoPara,
    String forma,
    String numNSU,
    String finalCartao,
    String mecanismoCartao,
    String idVendaCartao,
    int parcelas,
  }) =>
      PagamentoModel(
        codPag: codPag ?? this.codPag,
        tipo: tipo ?? this.tipo,
        forma: forma ?? this.forma,
        descricao: descricao ?? this.descricao,
        valor: valor ?? this.valor,
        bandeira: bandeira ?? this.bandeira,
        codAutorizacao: codAutorizacao ?? this.codAutorizacao,
        trocoPara: trocoPara ?? this.trocoPara,
        numNSU: numNSU ?? this.numNSU,
        finalCartao: finalCartao ?? this.finalCartao,
        mecanismoCartao: mecanismoCartao ?? this.mecanismoCartao,
        idVendaCartao: idVendaCartao ?? this.idVendaCartao,
        parcelas: parcelas ?? this.parcelas,
      );

  factory PagamentoModel.fromJson(Map<String, dynamic> json) => PagamentoModel(
        codPag: json["codPag"] == null ? null : json["codPag"],
        tipo: json["tipo"] == null ? null : json["tipo"],
        forma: json["forma"] == null ? null : json["forma"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        valor: json["valor"] == null ? null : json["valor"].toDouble(),
        bandeira: json["bandeira"] == null ? null : json["bandeira"],
        codAutorizacao:
            json["codAutorizacao"] == null ? null : json["codAutorizacao"],
        trocoPara:
            json["trocoPara"] == null ? null : json["trocoPara"].toDouble(),
         numNSU: json["numNSU"] == null ? null : json["numNSU"],
         finalCartao: json["finalCartao"] == null ? null : json["finalCartao"],
         mecanismoCartao: json["mecanismoCartao"] == null ? null : json["mecanismoCartao"],
         idVendaCartao: json["idVendaCartao"] == null ? null : json["idVendaCartao"],
         parcelas: json["parcelas"] == null ? 1 : json["parcelas"],
      );

  Map<String, dynamic> toJson() => {
        "codPag": codPag == null ? null : codPag,
        "tipo": tipo == null ? null : tipo,
        "forma": forma == null ? null : forma,
        "descricao": descricao == null ? null : descricao,
        "valor": valor == null ? null : valor,
        "bandeira": bandeira == null ? null : bandeira,
        "codAutorizacao": codAutorizacao == null ? null : codAutorizacao,
        "trocoPara": trocoPara == null ? null : trocoPara,
        "numNSU": numNSU == null ? null : numNSU,
        "finalCartao": finalCartao == null ? null : finalCartao,
        "mecanismoCartao": mecanismoCartao == null ? null : mecanismoCartao,
        "idVendaCartao": idVendaCartao == null ? null : idVendaCartao,
        "parcelas": parcelas == null ? 1 : parcelas,
      };
}
