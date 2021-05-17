import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:dio/dio.dart';

import 'endereco_interf_repository.dart';

class EnderecoRepository extends Disposable implements IEnderecoRepository {
  final AppController _appController = AppModule.to.get();

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
    var doc =
        await _appController.userAtualDocRef.collection('enderecos').add(dados);
    return doc.documentID;
    //
  }

  Future<void> alteraEndereco(
      {String id, String numero, String complem, double coordLat, double coordLong,}) async {
    //
    await _appController.userAtualDocRef
        .collection('enderecos')
        .document(id)
        .setData(
      {
        "numero": numero,
        "complemento": complem,
        "coordLat": coordLat,
        "coordLong": coordLong
      },
      merge: true,
    );
    //
  }

  Future<void> excluiEndereco(String id) async {
    //
    await _appController.userAtualDocRef
        .collection('enderecos')
        .document(id)
        .delete();
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
