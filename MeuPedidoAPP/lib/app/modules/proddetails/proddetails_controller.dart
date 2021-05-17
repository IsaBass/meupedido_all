import 'package:mobx/mobx.dart';

import 'package:MeuPedido/app/app_module.dart';

import 'package:meupedido_core/meupedido_core.dart';

import 'package:MeuPedido/app/categs/categs_controller.dart';

import 'repository/proddetails_interf_repository.dart';

part 'proddetails_controller.g.dart';

class ProddetailsController = _ProddetailsBase with _$ProddetailsController;

abstract class _ProddetailsBase with Store {
  final CNPJSController _cnpjsController = AppModule.to.get();
  final CategsController _categsController = AppModule.to.get();
  final IProddetailsRepository _repository;
  //
  _ProddetailsBase(this._repository);
  //
  @observable
  ProdutoModel prod;

  @observable
  double quantidade = 1;

  @action
  void updFalso() => quantidade = quantidade;

  @action
  void increment() => quantidade++;

  @action
  void decrement() {
    if (quantidade >= 1) quantidade--;
  }

  Future<void> criarCopiaProduto(ProdutoModel prod) async {
    var dR = _cnpjsController.cnpjAtivo.docRef;

    await dR.collection('produtos').add(prod.toJson());
  }

  @action
  Future<ProdutoModel> getProduto(String codigo) async {
    var dR = _cnpjsController.cnpjAtivo.docRef;
    //
    var doc = await dR.collection('produtos').document(codigo).get();
    if (doc == null) return null;
    //
    var m = doc.data;
    m['docId'] = doc.documentID;
    prod = ProdutoModel.fromJson(m);

    _getAdicionaisCateg();
    await _getAdicionaisProduto();

    prod.grupoAdicionais.sort((a, b) => a.ordem.compareTo(b.ordem));

    return prod;
  }

  Future<void> _getAdicionaisProduto() async {
    var gruposAdicionais = await _getGrpOpcionais();

    if (gruposAdicionais != null && gruposAdicionais.length > 0) {
      prod.grupoAdicionais.addAll(
          gruposAdicionais.map((e) => AdicionalGrpModel.modelZero(e)).toList());
    }
  }

  Future<List<AdicionalGrpModel>> _getGrpOpcionais() async {
    // isLoading = true;
    var listaAux = <AdicionalGrpModel>[];
    var query = await _repository.getGrpOpcionais(prod.codigo);

    for (var doc in query) {
      var ad = AdicionalGrpModel.fromJson(doc);
      if (!ad.determinaPreco) ad.ordem += 10;
      listaAux.add(ad);
    }

    // isLoading = false;
    return listaAux;
  }

  _getAdicionaisCateg() {
    if (prod.codCateg > 0) {
      var categ = _categsController.categs
          .firstWhere((element) => element.codCateg == prod.codCateg);

      if (categ?.grupoAdicionais != null && categ.grupoAdicionais.length > 0) {
        prod.grupoAdicionais.addAll(categ.grupoAdicionais
            .map((e) {
          var ad = AdicionalGrpModel.modelZero(e);
          ad.ordem += 50;
          return ad;
        }).toList());
      }
    }
  }

  @computed
  double get valorTotal {
    var tot = 0.00;
    for (var grp in prod.grupoAdicionais) {
      for (var adic in grp.adics) {
        if (!grp.determinaPreco) {
          if (adic.valor == grp.valorAtual) {
            // verifica se de escolha unica
            tot += (adic.preco ?? 0.00);
          } else {
            if (adic.quantidade > 0.00) {
              tot += (adic.quantidade * (adic.preco ?? 0.00));
            }
          }
        } else {
          if (adic.valor == grp.valorAtual && (adic.preco ?? 0.00) > 0.0) {
            prod.precoAtual = adic.preco;
          }
        }
      }
    }
    tot += prod.precoAtual;
    return tot * quantidade;
  }
}
