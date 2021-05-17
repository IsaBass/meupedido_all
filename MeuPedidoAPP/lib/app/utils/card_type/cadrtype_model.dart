// {
//     "type": "mastercard",
//     "niceType": "Mastercard",
//     "gaps": [
//         4,
//         8,
//         12
//     ],
//     "lengths": [
//         16
//     ],
//     "codeName": "CVC",
//     "codeSize": 3
// }

class CardType {
  String type;
  String niceType;
  List<int> gaps;
  List<int> lengths;
  String codeName;
  int codeSize;

  CardType(
      {this.type,
      this.niceType,
      this.gaps,
      this.lengths,
      this.codeName,
      this.codeSize});

  CardType.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    niceType = json['niceType'];
    gaps = json['gaps'].cast<int>();
    lengths = json['lengths'].cast<int>();
    codeName = json['codeName'];
    codeSize = json['codeSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['niceType'] = this.niceType;
    data['gaps'] = this.gaps;
    data['lengths'] = this.lengths;
    data['codeName'] = this.codeName;
    data['codeSize'] = this.codeSize;
    return data;
  }
}
