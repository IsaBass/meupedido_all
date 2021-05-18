import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';

import 'package:MeuPedido/app/app_controller.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'repository/carrinho_interf_repository.dart';

part 'carrinho_controller.g.dart';

class CarrinhoController = _CarrinhoBase with _$CarrinhoController;

abstract class _CarrinhoBase with Store {
  final ICarrinhoRepository _carrinhoRepository;

  _CarrinhoBase(this._carrinhoRepository) {
    enderecos = <EnderecoModel>[].asObservable();
  }

  final CartController _cartController = Modular.get<CartController>();
  final AppController _appController = Modular.get<AppController>();
  final AuthController _authController = Modular.get<AuthController>();
  final PageController pageController = PageController();
  final FCMFirebase _fcmFirebase = Modular.get<FCMFirebase>();

  @observable
  bool isLoading = false;
  @observable
  String tipoEntrega = 'FRETE';
  @action
  void setTipoEntrega(String novo) {
    tipoEntrega = novo;
    calculeFrete();
  }

  @observable
  String cupomAceito = '';
  @observable
  bool isLoadingCupom = false;

  @observable
  String idEndereco = '';
  @action
  void setCodEndereco(String novo) {
    idEndereco = novo;
    calculeFrete();
  }

  @observable
  ObservableList<EnderecoModel> enderecos;

  @observable
  String formaPagamento = 'ONLINE';
  @action
  void setformaPagamento(String novo) => formaPagamento = novo;
  @observable
  String tipoPagamento = 'CTCRED';
  @action
  void setTipoPagamento(String novo) => tipoPagamento = novo;

  ///
  Pedido criarPedido({Pedido pedido}) {
    Pedido ped;
    if (pedido != null) {
      ped = pedido;
    } else {
      ped = Pedido();
    }

    ped.codpedido = Random().nextInt(999999).toString();
    ped.status = '0';
    ped.dataHora = DateTime.now().millisecondsSinceEpoch;
    ped.totalProdutos = _cartController.cartAtual.valorTotal; //<<<<
    ped.valorDesconto = _cartController.cartAtual.descontoValor;
    ped.valorFrete = _cartController.cartAtual.vlrFrete;
    ped.totalFinal = _cartController.cartAtual.valorTotal;
    ped.tipoEntrega = tipoEntrega;

    ped.prods = _cartController.cartAtual.itens
        .map((e) => ProdPedidoModel.fromCartItem(e))
        .toList();
    ped.usuario = UsuarioModel.fromUserModel(_authController.userAtual);
    if (idEndereco != null && idEndereco.isNotEmpty) {
      ped.endereco = enderecos.firstWhere((e) => e.docId == idEndereco);
    }
    var pag = PagamentoModel(
      codPag: '01?',
      tipo: tipoPagamento,
      forma: formaPagamento,
      codAutorizacao: '',
      descricao: tipoPagamento == 'DIN'
          ? 'Dinheiro'
          : tipoPagamento == 'CTCRED'
              ? 'Cartão Crédito'
              : 'Cartão Débito',
      bandeira: '',
      trocoPara: 0,
      valor: _cartController.cartAtual.valorTotal,
    );
    //
    ped.pagamentos.add(pag);
    //
    return ped;
  }

  @action
  Future<String> gravarPedido(Pedido pedido) async {
    //
    isLoading = true;
    var numPedido = await _carrinhoRepository.gravarPedido(pedido.toJson());

    if (numPedido != null) {
      await _cartController
          .excluiCarrinho(); //_authController.userAtual.docRef);

    }

    _fcmFirebase.fcmAdministradores(
      cnpj: _appController.cnpjAtivoDocId,
      titulo: "NOVO Pedido",
      body: "#${pedido.codpedido} recebido.",
    );

    isLoading = false;
    return numPedido;
  }

  @action
  Future<String> gravarPedidoTemporario() async {
    isLoading = true;
    var idPedido = await _carrinhoRepository.gravarPedidoTemporario();

    isLoading = false;
    return idPedido;
  }

  @action
  Future<void> excluirPedidoTemporario(String idPedido) async {
    isLoading = true;
    await _carrinhoRepository.excluiPedidoTemporario(idPedido);
    isLoading = false;
  }

  @action
  Future<void> getEnderecos() async {
    isLoading = true;
    var docs = await _carrinhoRepository.getEnderecos();

    var lAux = <EnderecoModel>[];
    for (var doc in docs) {
      lAux.add(EnderecoModel.fromJson(doc));
    }

    enderecos = lAux.asObservable();
    if (idEndereco.isEmpty && enderecos.length > 0) {
      idEndereco = enderecos[0].docId;
    }
    calculeFrete();
    isLoading = false;
  }

  @action
  Future<void> excluiEndereco(EnderecoModel end) async {
    isLoading = true;
    //
    var id = end.docId;
    await _carrinhoRepository.excluiEndereco(id);
    enderecos.remove(end);
    //
    if (idEndereco == id && enderecos.length > 0) {
      idEndereco = enderecos[0].docId;
    } else {
      idEndereco = '';
    }
    calculeFrete();

    isLoading = false;
  }

  @action
  Future<Map> getCupom(String tagCupom) async {
    isLoadingCupom = true;
    _cartController.setCupomDesconto(null);
    if (tagCupom == null || tagCupom.isEmpty) {
      cupomAceito = '';
      isLoadingCupom = false;
      return null;
    }

    isLoadingCupom = true;
    var map = await _carrinhoRepository.getCupomDesconto(tagCupom);
    if (map == null) {
      cupomAceito = 'N';
      isLoadingCupom = false;
      return {"aceito": false, "message": "Cupom não encontrado"};
    }

    var cupom = CupomDesconto.fromMap(map);

    //validacoes do cupom
    var totalProds = _cartController.cartAtual.valorProdutos;
    if (cupom.valorMinimo > totalProds) {
      cupomAceito = 'N';
      isLoadingCupom = false;
      return {
        "aceito": false,
        "message":
            "Compre mais ${(cupom.valorMinimo - totalProds).toStringAsFixed(2)} para aplicar este cupom."
      };
    }

    ///
    var compare = DateTime.fromMillisecondsSinceEpoch(cupom.dtHoraFim)
        .compareTo(DateTime.now());

    if (compare < 0) {
      cupomAceito = 'N';
      isLoadingCupom = false;
      return {"aceito": false, "message": "Cupom fora da Validade."};
    }
    //
    compare = DateTime.fromMillisecondsSinceEpoch(cupom.dtHoraInicio)
        .compareTo(DateTime.now());

    if (compare > 0) {
      cupomAceito = 'N';
      isLoadingCupom = false;
      return {"aceito": false, "message": "Cupom ainda não está em Validade."};
    }
    //
    if (cupom.qtdMax > 0 && cupom.qtdVendido >= cupom.qtdMax) {
      cupomAceito = 'N';
      isLoadingCupom = false;
      return {"aceito": false, "message": "Cupom sem estoque."};
    }
    //
    _cartController.setCupomDesconto(cupom);

    cupomAceito = 'S';
    isLoadingCupom = false;
    return {"aceito": true};
  }

  @action
  Future<void> calculeFrete({EnderecoModel endereco = null}) async {
    isLoading = true;
    if (tipoEntrega == 'RET' || idEndereco == null || idEndereco.isEmpty) {
      _cartController.cartAtual.setVlrFrete(0.00);
      isLoading = false;
      return;
    }
    //
    EnderecoModel end = endereco != null
        ? endereco
        : enderecos.firstWhere((e) => e.docId == idEndereco);
    //
    if (end.coordLat == null || end.coordLong == null) {
      var enderecoOrig =
          " ${end.logradouro}, ${end.numero}, ${end.bairro}, ${end.cidade}, ${end.uf}";
      var destino = await getGEO_DoEndereco(enderecoOrig);
      if (destino == null) {
        _cartController.cartAtual.setVlrFrete(0.00);
        isLoading = false;
        return;
      }
      end.coordLat = destino[0];
      end.coordLong = destino[1];
    }
    //
    var configs = await _appController.getCnpjConfigs();
    if (configs.coordLat == null || configs.coordLong == null) {
      _cartController.cartAtual.setVlrFrete(0.00);
      isLoading = false;
      return;
    }
    //
    var distancia = await getGEO_Distancia(
        configs.coordLat, configs.coordLong, end.coordLat, end.coordLong);
    //
    var vlrFrete = 0.0;
    vlrFrete = configs.freteBase;
    if (distancia <= configs.freteKmBase) {
      _cartController.cartAtual.setVlrFrete(vlrFrete);
      isLoading = false;
      return;
    }
    var diferencaKm = (distancia / 1000 - configs.freteKmBase).toInt() + 1;
    vlrFrete += (diferencaKm * configs.freteKm);

    isLoading = false;
    return _cartController.cartAtual.setVlrFrete(vlrFrete);
  }
}
