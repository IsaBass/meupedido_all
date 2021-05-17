import 'package:meupedido_core/meupedido_core.dart';
import 'package:mobx/mobx.dart';

import 'list_enderecos_interf_repository.dart';
part 'list_enderecos_controller.g.dart';

class ListEnderecosController = _ListEnderecosControllerBase
    with _$ListEnderecosController;

abstract class _ListEnderecosControllerBase with Store {

  final ListEnderecosRepositoryI _repository; 
     
  _ListEnderecosControllerBase(this._repository) {
    enderecos = <EnderecoModel>[].asObservable();
  }
  @observable
  bool isLoading = false;
  @observable
  ObservableList<EnderecoModel> enderecos;

  @action
  Future<void> getEnderecos() async {
    isLoading = true;
    var docs = await _repository.getEnderecos();

    var lAux = <EnderecoModel>[];
    for (var doc in docs) {
      lAux.add(EnderecoModel.fromJson(doc));
    }

    enderecos = lAux.asObservable();
    
    isLoading = false;
  }


  @action
  Future<void> excluiEndereco(EnderecoModel end) async {
    isLoading = true;
    //
    await _repository.excluiEndereco(end.docId);
    enderecos.remove(end);
    //
    isLoading = false;
  }
}
