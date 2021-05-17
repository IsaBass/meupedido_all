import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

CnpjModel cnpjModelFromJson(String str) => CnpjModel.fromJson(json.decode(str));

String cnpjModelToJson(CnpjModel data) => json.encode(data.toJson());

class CnpjModel {
  String docId;
  DocumentReference docRef;
  bool ativo;
  String descricao;
  String tipo;
  String identificador;
  String cChave;
  //List<Filial> dadosFiliais;

  CnpjModel(
      {this.docId,
      this.ativo,
      this.descricao,
      // this.dadosFiliais,
      this.tipo,
      this.identificador,
      this.cChave,
      this.docRef});

  factory CnpjModel.fromJson(Map<String, dynamic> json) => CnpjModel(
        docId: json["docId"] == null ? null : json["docId"],
        docRef: json["docRef"] == null ? null : json["docRef"],
        ativo: json["ativo"] == null ? null : json["ativo"],
        descricao: json["descricao"] == null ? null : json["descricao"],
        // filiais: json["filiais"] == null
        //     ? null
        //     : List<String>.from(json["filiais"].map((x) => x)),
        tipo: json["tipo"] == null ? null : json["tipo"],
        identificador:
            json["identificador"] == null ? null : json["identificador"],
        cChave: json["cChave"] == null ? null : json["cChave"],
      );

  Map<String, dynamic> toJson() => {
        "docId": docId == null ? null : docId,
        "ativo": ativo == null ? null : ativo,
        "descricao": descricao == null ? null : descricao,
        // "filiais":
        //     filiais == null ? null : List<dynamic>.from(filiais.map((x) => x)),
        "tipo": tipo == null ? null : tipo,
        "identificador": identificador == null ? null : identificador,
        "cChave": cChave == null ? null : cChave,
      };

  // List<DropdownMenuItem> filiaisDropDownMenuItens() {

  //   List<DropdownMenuItem> listAux = [];

  //    listAux.add( DropdownMenuItem<String>(value: 'Todos', child: Text('Exibir Todos')));

  //   if (dadosFiliais != null)
  //     listAux.addAll(dadosFiliais
  //         .map((filial) => DropdownMenuItem<String>(
  //               value: filial.cnpj,
  //               child: Row(
  //                 children: <Widget>[
  //                   // Icon(
  //                   //   Icons.business,
  //                   //   size: 20,
  //                   //   color: cnpjAtivo == empresa.cnpjM
  //                   //       ? Colors.teal[800]
  //                   //       : Colors.grey,
  //                   // ),
  //                   // SizedBox(width: 10),
  //                   Text(filial.descricao),
  //                 ],
  //               ),
  //             ))
  //         .toList());

  //   return listAux;
  // }
}

// class Filial {
//   String cnpj;
//   String descricao;
//   String descReduz;
//   bool ativo;
//   bool visivel;

//   Filial({this.cnpj, this.descricao, this.descReduz, this.ativo, this.visivel});

//    factory Filial.fromJson(Map<String, dynamic> json) => Filial(
//         cnpj: json["cnpj"] == null ? null : json["cnpj"],
//         descricao: json["descricao"] == null ? null : json["descricao"],
//         descReduz: json["descReduz"] == null ? null : json["descReduz"],
//         ativo: json["ativo"] == null ? null : json["ativo"],
//         visivel: json["visivel"] == null ? null : json["visivel"],
//       );

//  Map<String, dynamic> toJson() => {
//         "cnpj": cnpj == null ? null : cnpj,
//         "descricao": descricao == null ? null : descricao,
//         "descReduz": descReduz == null ? null : descReduz,
//         "ativo": ativo == null ? null : ativo,
//         "visivel": visivel == null ? null : visivel,
//       };
// }
