import 'package:flutter/material.dart';

import 'package:meupedido_core/core/cnpjs/cnpj_model.dart';
// import 'package:meupedido_core/core/cnpjs/cnpjs_controller.dart';

enum Perfil { normal, superv, master, dev }

class UserModel {
  // final CNPJSController _cnpjsController = Modular.get<CNPJSController>();
  //
  // User firebasebUser;
  String uid;
  String nome;
  String email;
  Perfil perfil;
  String tokenCelular;
  String urlImg;
  String telefone;
  String cnpjPadrao;
  DateTime dataNascimento;
  List<UserEmpresa> empresas;
  List<String> favoritos;

  int idxEmpresaAtual;
  // DocumentReference docRef;

  void clear() {
    nome = '';
    //firebasebUser = null;
    email = '';
    tokenCelular = '';
    urlImg = '';
    dataNascimento = DateTime.tryParse('0');
    empresas = [];
    telefone = '';
    perfil = Perfil.normal;
  }

  void carregaDoMap(Map<String, dynamic> docUser, String cnpj) {
    uid = docUser['uid'] ?? "";
    nome = docUser['nome'] ?? "";
    email = docUser['email'] ?? "";
    urlImg = docUser['urlImg'] ?? "";
    // docRef = docUser['docRef'] == null ? null : docUser['docRef'];
    telefone = docUser['telefone'] == null ? '' : docUser['telefone'];

    //if (kIsWeb)   print(' é web kisweb');
    // if (Platform.isAndroid)   esssa chamada dá erro na web (Platform)
    // print(' é android');

    if (docUser['dataNascimento'] != null) {
      try {
        dataNascimento = DateTime.parse(docUser['dataNascimento']
            .toDate()
            .toString()); // esse normal pra mobile
        print('deu certo dataNascimento pra mobile (1) ');
      } on Exception catch (e) {
        dataNascimento = null;
        print('deu ERRO dataNascimento pra mobile (1) ${e.toString()}');
      }

      if (dataNascimento == null) {
        try {
          dataNascimento = DateTime.parse(docUser['dataNascimento'].toString());
          print('deu certo dataNascimento pra web (2) ');
        } on Exception catch (e) {
          dataNascimento = null;
          print('deu ERRO dataNascimento pra web (2) $e ');
        }
      }
    } else {
      dataNascimento = null;
      print('a dataNascimento é originalmente nula');
    }

    // dataNascimento = (docUser['dataNascimento'] == null)
    //     ? null
    //     : DateTime.parse(
    //         kIsWeb
    //             // ? docUser['dataNascimento'].toString() //esse é pra web
    //             ? docUser['dataNascimento'].toDate().toString()
    //             : docUser['dataNascimento'].toDate().toString(), // esse é pra mobile
    //       );

    cnpjPadrao = docUser['cnpjPadrao'] == null ? null : docUser['cnpjPadrao'];

    tokenCelular =
        docUser['tokenCelular'] == null ? null : docUser['tokenCelular'];
    perfil =
        perfilFromString(docUser['perfil'] == null ? '' : docUser['perfil']);

    if (cnpj != null)
      favoritos = docUser['favoritos$cnpj'] == null
          ? []
          : docUser['favoritos$cnpj'].cast<String>();
    else
      favoritos = [];
  }

  Map<String, dynamic> toMap(String cnpj) {
    Map<String, dynamic> userData = {};

    userData['uid'] = uid;
    userData['nome'] = nome;
    userData['email'] = email;
    userData['dataNascimento'] = dataNascimento;
    userData['telefone'] = telefone;
    userData['dataUltAlteracao'] = DateTime.now();
    userData['cnpjPadrao'] = cnpjPadrao;
    userData["empresas"] = (empresas == null || empresas == [])
        ? null
        : List<Map>.from(
            empresas.map((x) => {"cnpj": x.cnpjM.docId, "status": x.status}));
    userData['tokenCelular'] = tokenCelular;
    userData['urlImg'] = urlImg;
    userData['perfil'] = perfilString();
    if (cnpj != "") userData['favoritos$cnpj'] = favoritos;

    return userData;
  }

  String perfilString() {
    switch (perfil) {
      case Perfil.normal:
        return 'normal';
        break;
      case Perfil.superv:
        return 'superv';
        break;
      case Perfil.master:
        return 'master';
        break;
      case Perfil.dev:
        return 'dev';
        break;
      default:
        return 'normal';
    }
  }

  Perfil perfilFromString(String st) {
    switch (st) {
      case 'normal':
        return Perfil.normal;
        break;
      case 'superv':
        return Perfil.superv;
        break;
      case 'master':
        return Perfil.master;
        break;
      case 'dev':
        return Perfil.dev;
        break;
      default:
        return Perfil.normal;
    }
  }

  List<DropdownMenuItem> empresasDropDownMenuItens(String cnpjAtivo) {
    List<DropdownMenuItem> listAux = [];

    // listAux.add( DropdownMenuItem<String>(value: 'Todos', child: Text('Exibir Todos')));

    if (empresas != null)
      listAux.addAll(empresas
          .map((empresa) => DropdownMenuItem<CnpjModel>(
                value: empresa.cnpjM,
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.business,
                      size: 20,
                      color: cnpjAtivo == empresa.cnpjM.docId
                          ? Colors.teal[800]
                          : Colors.grey,
                    ),
                    SizedBox(width: 10),
                    Text(empresa.cnpjM.descricao),
                  ],
                ),
              ))
          .toList());

    return listAux;
  }

  void addEmpresa({CnpjModel cnpjM, String status = 'PEND'}) {
    this.empresas.add(
          UserEmpresa(cnpjM: cnpjM, status: status),
        );
  }
}

class UserEmpresa {
  CnpjModel cnpjM;

  String status;

  UserEmpresa({@required this.cnpjM, @required this.status});
}
