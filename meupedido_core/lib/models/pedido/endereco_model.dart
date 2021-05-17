

class EnderecoModel {
  String docId;
  String logradouro;
  String numero;
  String complemento;
  String bairro;
  String cidade;
  String uf;
  String cep;
  double coordLat;
  double coordLong;

  EnderecoModel({
    this.docId,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.cep,
    this.coordLat,
    this.coordLong,
  });

  EnderecoModel copyWith({
    String docId,
    String logradouro,
    String numero,
    String complemento,
    String bairro,
    String cidade,
    String uf,
    String cep,
    double coordLat,
    double coordLong,
  }) =>
      EnderecoModel(
        docId: docId ?? this.docId,
         cep: cep ?? this.cep,
        logradouro: logradouro ?? this.logradouro,
        numero: numero ?? this.numero,
        complemento: complemento ?? this.complemento,
        bairro: bairro ?? this.bairro,
        cidade: cidade ?? this.cidade,
        uf: uf ?? this.uf,
        coordLat: coordLat ?? this.coordLat,
        coordLong: coordLong ?? this.coordLong,
      );

  factory EnderecoModel.fromJson(Map<String, dynamic> json) => EnderecoModel(
        docId: json["docId"] == null ? null : json["docId"],
        logradouro: json["logradouro"] == null ? null : json["logradouro"],
        numero: json["numero"] == null ? null : json["numero"],
        complemento: json["complemento"] == null ? null : json["complemento"],
        bairro: json["bairro"] == null ? null : json["bairro"],
        cidade: json["cidade"] == null ? null : json["cidade"],
        uf: json["UF"] == null ? null : json["UF"],
        cep: json["cep"] == null ? null : json["cep"],
        coordLat: json["coordLat"] == null ? null : json["coordLat"].toDouble(),
        coordLong: json["coordLong"] == null ? null : json["coordLong"].toDouble(),
      );

 
  Map<String, dynamic> toJson() => {
        "logradouro": logradouro == null ? null : logradouro,
        "numero": numero == null ? null : numero,
        "complemento": complemento == null ? null : complemento,
        "bairro": bairro == null ? null : bairro,
        "cidade": cidade == null ? null : cidade,
        "UF": uf == null ? null : uf,
        "cep": cep == null ? null : cep,
        "coordLat": coordLat == null ? null : coordLat,
        "coordLong": coordLong == null ? null : coordLong,
      };
}
