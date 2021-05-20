import 'package:MeuPedido/app/app_controller.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'categs_interf_repository.dart';

part 'categs_controller.g.dart';

class CategsController = _CategsControllerBase with _$CategsController;

abstract class _CategsControllerBase with Store {
  final ICategsRepository _categsRepository;
  final AppController _appController;

  _CategsControllerBase(this._categsRepository, this._appController) {
    //recarregaAllCategs();
  }

  @observable
  bool isLoading = false;

  @observable
  ObservableList<CategoriaModel> categs;

  @action
  Future<void> recarregaAllCategs() async {
    isLoading = true;
    var listaAux = <CategoriaModel>[];
    categs = listaAux.asObservable();

    var query =
        await _categsRepository.allCategorias(_appController.cnpjAtivo.docId);

    for (var doc in query) {
      var ct = CategoriaModel.fromJson(doc);
      ct.grupoAdicionais = await getCategGrpOpcionais(ct.docId);
      listaAux.add(ct);
    }
    categs = listaAux.asObservable();
    isLoading = false;
  }

  Future<List<AdicionalGrpModel>> getCategGrpOpcionais(
      String docIdCateg) async {
    // isLoading = true;
    var listaAux = <AdicionalGrpModel>[];
    //
    var query = await _categsRepository.getCategGrpOpcionais(
        _appController.cnpjAtivo.docId, docIdCateg);
    //
    for (var doc in query) {
      listaAux.add(AdicionalGrpModel.fromJson(doc));
    }
    // isLoading = false;
    return listaAux;
  }
}
