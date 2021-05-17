import 'package:MeuPedido/app/app_controller.dart';
import 'package:MeuPedido/app/app_module.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:meupedido_core/meupedido_core.dart';

import 'carrinho_interf_repository.dart';

class CarrinhoRepository extends Disposable implements ICarrinhoRepository {
  //
  final AppController _appController = AppModule.to.get();
  final AuthController _authController = AppModule.to.get();

  /// USAR APENAS PARA GRAVACAO DE NOVO PEDIDO
  @override
  Future<String> gravarPedido(Map pedido) async {
    //
    var docRef = _appController.cnpjAtivoDocRef;

    String docId;
    try {
      if (pedido['docId'] == null) {
        var doc = await docRef.collection('pedidos').add(pedido);
        docId = doc.id;
      } else {
        docId = pedido['docId'];
        await docRef.collection('pedidos').doc(docId).set(pedido);
      }
    } catch (e) {
      return null;
    }

    //
    try {
      _registraNoUsuario(pedido, docId);
    } catch (e) {}
    //
    try {
      _registraHistoricoPedido(
          idPedido: docId,
          campoAlterado: 'Novo',
          valorNovo: 'Criado',
          valorAnterior: '');
    } catch (e) {}
    //
    try {
      _registraLimbo(idPedido: docId, novaSituacao: 'NOVO');
    } catch (e) {}
    //

    return docId;
    //
  }

  Future<void> _registraNoUsuario(Map pedido, String docId) async {
    //
    await _appController.userAtualDocRef
        .collection('pedidos${_appController.cnpjAtivoDocRef.id}')
        .doc(docId)
        .set({
      "idPedido": docId,
      "dataHora": pedido['dataHora'],
      "totalFinal": pedido['totalFinal'],
      "prods": pedido['prods']
          .map((e) =>
              e['quantidade'].toStringAsFixed(0) + ' X ' + e['descricao'])
          .toList()
    });
    //
  }

  Future<String> gravarPedidoTemporario() async {
    //
    var doc = await _appController.cnpjAtivoDocRef
        .collection('pedidos')
        .add({"temporario": true});
    //
    return doc.id;
  }

  Future<void> excluiPedidoTemporario(String idPedido) async {
    //
    await _appController.cnpjAtivoDocRef
        .collection('pedidos')
        .doc(idPedido)
        .delete();
    //
  }

  Future _registraLimbo({String idPedido, String novaSituacao}) async {
    //
    Map<String, dynamic> mapLimbo = {
      "idPEDIDO": idPedido,
      "novaSituacao": novaSituacao,
      "ultAlteracao": DateTime.now().millisecondsSinceEpoch
    };

    await _appController.cnpjAtivoDocRef.collection('limbo').add(mapLimbo);

    print(' >> CARRINHO Repository.REGISTRA LIMBO LOJA ');
    //
  }

  Future<void> _registraHistoricoPedido(
      {String idPedido,
      String campoAlterado,
      String valorNovo,
      String valorAnterior}) async {
    //
    Map<String, dynamic> mapHistorico = {
      "userId": _appController.userAtualDocRef.id,
      "userName": _authController.userAtual.nome,
      "origem": "App", //  "App" OR "PC"
      "dataHora": DateTime.now().millisecondsSinceEpoch,
      "campo": campoAlterado,
      "anterior": valorAnterior,
      "novo": valorNovo,
    };

    await _appController.cnpjAtivoDocRef
        .collection('pedidos')
        .doc(idPedido)
        .collection('historico')
        .add(mapHistorico);

    print(' >> carrinho Repository.REGISTRA HISTORICO PEDIDO ');
    //
  }

  //>>>>>  SECAO ENDERECO E BUSCA CEP  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< ///

  Future<List<Map>> getEnderecos() async {
    //
    var docs =
        await _appController.userAtualDocRef.collection('enderecos').get();
    //
    List<Map> lAux = [];
    for (var doc in docs.docs) {
      var m = doc.data();
      m['docId'] = doc.id;
      lAux.add(m);
    }

    return lAux;
    //
  }

  Future<String> gravaEndereco(Map dados) async {
    //
    var doc =
        await _appController.userAtualDocRef.collection('enderecos').add(dados);
    return doc.id;
    //
  }

  Future<void> alteraEndereco(
      {String id, String numero, String complem}) async {
    //
    await _appController.userAtualDocRef.collection('enderecos').doc(id).set(
      {"numero": numero, "complemento": complem},
      SetOptions(merge: true),
    );
    //
  }

  Future<void> excluiEndereco(String id) async {
    //
    await _appController.userAtualDocRef
        .collection('enderecos')
        .doc(id)
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

  Future<Map> getCupomDesconto(String tagCupom) async {
    //
    var docs = await _appController.cnpjAtivoDocRef
        .collection('cupomdesconto')
        .where('tagCupom', isEqualTo: tagCupom.toUpperCase())
        .get();
    //
    if (docs == null || (docs.docs?.length ?? 0) == 0) {
      return null;
    }

    return (docs.docs[0].data())..['idCupom'] = docs.docs[0].id;
    //
  }

  //dispose will be called automatically
  @override
  void dispose() {}
}
