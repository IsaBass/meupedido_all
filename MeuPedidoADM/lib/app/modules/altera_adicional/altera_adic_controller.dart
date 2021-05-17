import 'package:meupedidoADM/app/modules/altera_adicional/repository/altera_adic_repository.dart';
import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'repository/altera_adic_interf.dart';

part 'altera_adic_controller.g.dart';

class AlteraAdicController = _AlteraAdicControllerBase
    with _$AlteraAdicController;

abstract class _AlteraAdicControllerBase with Store {
  final IAlteraAdicRepository _repository = AlteraAdicRepository();

  @observable
  bool isLoading = false;

  _AlteraAdicControllerBase();

  Future saveGrupoAdic(AdicionalGrpModel grupo) async {
    isLoading = true;

    String resp = '';

    if (grupo.origem == 'C') {
      if (grupo.docId == null) {
        resp = await _repository.novoGrupoCateg(grupo.toJson(), grupo.idOrigem);
      } else {
        resp = await _repository.saveGrupoCateg(grupo.toJson(), grupo.idOrigem);
      }
    }
    if (grupo.origem == 'P') {
      if (grupo.docId == null) {
        resp = await _repository.novoGrupoProd(grupo.toJson(), grupo.idOrigem);
      } else {
        resp = await _repository.saveGrupoProd(grupo.toJson(), grupo.idOrigem);
      }
    }

    if (resp != '') {
      grupo.docId = resp;
    }
    isLoading = false;
  }
}
