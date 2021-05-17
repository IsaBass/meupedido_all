import 'package:mobx/mobx.dart';

import 'package:meupedido_core/core/cnpjs/cnpj_repository_interf.dart';
import 'package:meupedido_core/meupedido_core.dart';

part 'empresas_controller.g.dart';

class EmpresasController = _EmpresasBase with _$EmpresasController;

abstract class _EmpresasBase with Store {
  final ICnpjRepository _cnpjRepository;
  // final CNPJSController _cnpjsController;

  _EmpresasBase(this._cnpjRepository) {
    carregaEmpresas();
  }

  @observable
  bool isLoading = false;

  @observable
  ObservableList<CnpjModel> listaEmp;

  @action
  carregaEmpresas() async {
    //listaEmp =
    await _getAllEmpresas();
  }

  @action
  Future<List<CnpjModel>> _getAllEmpresas() async {
    isLoading = true;

    var query = await _cnpjRepository.getAllCnpjs();

    if (query == null || query.isEmpty) {
      isLoading = false;
      return null;
    }

    List<CnpjModel> lista = [];

    for (var doc in query) {
      lista.add(CnpjModel.fromJson(doc));
    }

    listaEmp = lista.asObservable();
    isLoading = false;
    return lista;
  }

  @action
  Future saveEmpresa(CnpjModel emp) async {
    isLoading = true;

    await _cnpjRepository.saveCNPJ(emp);

    listaEmp = listaEmp;

    isLoading = false;
  }

  @action
  Future saveNovaEmpresa(CnpjModel emp) async {
    isLoading = true;

    await _cnpjRepository.saveNovoCNPJ(emp);

    carregaEmpresas();

    isLoading = false;
  }

  //  @action
  // Future removeFilial(CnpjModel emp, Filial filial) async {
  //   isLoading = true;
  //   emp.dadosFiliais.remove(filial);
  //   emp.filiais.remove(filial.cnpj);
  //   await _cnpjRepository.saveCNPJ(emp);
  //   isLoading = false;
  // }

}
