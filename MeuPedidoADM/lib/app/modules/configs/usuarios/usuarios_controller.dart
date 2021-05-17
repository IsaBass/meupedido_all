import 'package:meupedido_core/meupedido_core.dart';

import 'package:mobx/mobx.dart';

import 'repository/usuarios_repository_interf.dart';

part 'usuarios_controller.g.dart';

class UsuariosController = _UsuariosBase with _$UsuariosController;

abstract class _UsuariosBase with Store {
  final IUsuariosRepository _repository;
  final CNPJSController _cnpjsController;

  _UsuariosBase(this._repository, this._cnpjsController) {
    List<UserModel> list = [];
    listaUsuarios = list.asObservable();
  }

  @observable
  ObservableList<UserModel> listaUsuarios;

  @observable
  bool isLoading = false;

  @action
  Future<List<UserModel>> getAllUsuarios(String cnpj) async {
    isLoading = true;
    //
    var query = await _repository.getAllUsuarios(cnpj);
    //
    List<UserModel> lista = [];

    for (var doc in query) {
      //print(doc.data);
      UserModel user = new UserModel();
      user.carregaDoMap(doc);

      user.empresas = [];
      int idx = 0;
      for (Map emp in doc["empresas"]) {
        if (emp['cnpj'] == cnpj) {
          user.idxEmpresaAtual = idx;
        }

        ////
        CnpjModel pj =
            await _cnpjsController.getCnpjM(emp['cnpj'], carregaFiliais: false);
        //

        user.empresas.add(
          UserEmpresa(cnpjM: pj, status: emp['status']),
        );
        idx++;
      }

      lista.add(user);
    }

    listaUsuarios = lista.asObservable();
    isLoading = false;
    return lista;
  }

  @action
  Future salvarUser(UserModel user) async {
    isLoading = true;
    await _repository.salvarUsuario(user.docRef, user.toMap());
    isLoading = false;
  }

  @action
  void setPerfil(UserModel usu, Perfil perfil) {
    usu.perfil = perfil;
    listaUsuarios = listaUsuarios;
  }

  @action
  void setStatusEmpresa(UserModel usu, String status) {
    usu.empresas[usu.idxEmpresaAtual].status = status;
    listaUsuarios = listaUsuarios;
  }
}
