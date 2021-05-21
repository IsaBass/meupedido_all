import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeBase with _$HomeController;

abstract class _HomeBase with Store {
  // final IHomeRepository _homeRepository;
  final PageController pageController = PageController(keepPage: true);

  // _HomeBase(this._homeRepository);

  ////
  // @observable
  // String categAtiva = '';
  // @action
  // void mudaCategAtiva(String categ) => categAtiva = categ;

  ///
  @observable
  int tabActive = 0;
  @action
  void setTabActive(int tab) => tabActive = tab;
  @computed
  String get tituloTab {
    switch (tabActive) {
      case 1:
        return 'Favoritos';
        break;
      case 2:
        return 'Carrinho';
        break;
      case 3:
        return 'Seus Pedidos';
        break;
      case 4:
        return 'Perfil';
        break;
      default:
        return 'Home';
    }
  }
}
