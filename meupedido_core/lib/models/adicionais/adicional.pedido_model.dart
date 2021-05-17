
class AdicionalPedidoModel {
  int codigo;
  String idGrpAdic;
  String descricao;
  double valorUnit;
  double quantidade;
  bool determinaPreco;

  AdicionalPedidoModel(
      {this.codigo, this.descricao, this.valorUnit, this.quantidade, this.determinaPreco, this.idGrpAdic});

  AdicionalPedidoModel.fromJson(Map<String, dynamic> json) {
    codigo = json['codigo'];
    descricao = json['descricao'];
    valorUnit = json['valorUnit'].toDouble();
    quantidade = json['quantidade'].toDouble();
    determinaPreco = json['determinaPreco'] != null ? json['determinaPreco'] : false ;
    idGrpAdic = json['idGrpAdic'] != null ? json['idGrpAdic'] : '' ;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['codigo'] = this.codigo;
    data['descricao'] = this.descricao;
    data['valorUnit'] = this.valorUnit;
    data['quantidade'] = this.quantidade == 0 ? 1 : this.quantidade;
    data['determinaPreco'] = this.determinaPreco == null ? false : this.determinaPreco;
    data['idGrpAdic'] = this.idGrpAdic == null ? null : this.idGrpAdic;
    return data;
  }
}