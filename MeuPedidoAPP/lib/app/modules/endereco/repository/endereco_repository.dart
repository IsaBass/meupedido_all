import 'package:MeuPedido/app/app_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import 'endereco_interf_repository.dart';

class EnderecoRepository extends Disposable implements IEnderecoRepository {
  final AppController _appController;

  EnderecoRepository(this._appController);

  DocumentReference get userAtualDocRef => FirebaseFirestore.instance
      .collection("users")
      .doc(_appController.userAtual.uid);

  //>>>>>  SECAO ENDERECO E BUSCA CEP  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ///

  // Future<List<Map>> getEnderecos() async {
  //   //
  //   var docs = await _appController.userAtualDocRef
  //       .collection('enderecos')
  //       .getDocuments();
  //   //
  //   List<Map> lAux = [];
  //   for (var doc in docs.documents) {
  //     var m = doc.data;
  //     m['docId'] = doc.documentID;
  //     lAux.add(m);
  //   }

  //   return lAux;
  //   //
  // }

  Future<String> gravaEndereco(Map dados) async {
    //
    var doc = await userAtualDocRef.collection('enderecos').add(dados);
    return doc.id;
    //
  }

  Future<void> alteraEndereco({
    String id,
    String numero,
    String complem,
    double coordLat,
    double coordLong,
  }) async {
    //
    await userAtualDocRef.collection('enderecos').doc(id).set(
      {
        "numero": numero,
        "complemento": complem,
        "coordLat": coordLat,
        "coordLong": coordLong
      },
      SetOptions(merge: true),
    );
    //
  }

  Future<void> excluiEndereco(String id) async {
    //
    await userAtualDocRef.collection('enderecos').doc(id).delete();
    //
  }

  Future<Map> buscaCEP(String cep) async {
    //
    try {
      Response response =
          await Dio().get("https://viacep.com.br/ws/$cep/json/");
      return response.data;
    } catch (e) {
      return {"erro": "não encontrado"};
    }
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
