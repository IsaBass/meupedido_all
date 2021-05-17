// import 'package:mobx/mobx.dart';

// import 'package:meupedido_core/meupedido_core.dart';

// import 'repository/endereco_interf_repository.dart';

// part 'endereco_controller.g.dart';

// class EnderecoController = _EnderecoBase with _$EnderecoController;

// abstract class _EnderecoBase with Store {
//   final IEnderecoRepository _repository;

//   @observable
//   bool isLoading = false;

//   _EnderecoBase(this._repository);

//   @action
//   Future<String> gravaEndereco(EnderecoModel end) async {
//     isLoading = true;
//     var s = await _repository.gravaEndereco(end.toJson());
//     isLoading = false;
//     return s;
//   }

//   @action
//   Future<void> excluiEndereco(EnderecoModel end) async {
//     isLoading = true;
//     //
//     var id = end.docId;
//     await _repository.excluiEndereco(id);
//     // enderecos.remove(end);
//     //

//     isLoading = false;
//   }

//   @action
//   Future<void> alteraEndereco(EnderecoModel end) async {
//     isLoading = true;
//     //
//     await _repository.alteraEndereco(
//       id: end.docId,
//       complem: end.complemento,
//       numero: end.numero,
//       coordLat: end.coordLat,
//       coordLong: end.coordLong
//     );
//     //
//     isLoading = false;
//   }

//   @action
//   Future<Map> buscaCEP(String cep) async {
//     isLoading = true;
//     var ret = await _repository.buscaCEP(cep);
//     isLoading = false;
//     return ret;
//   }

// }
