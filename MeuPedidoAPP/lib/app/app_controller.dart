
import 'package:MeuPedido/app/app_repository_interf.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:meupedido_core/meupedido_core.dart';


part 'app_controller.g.dart';

class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  final AuthController _authController;
  final CNPJSController _cnpjsController;
  final IAppRepository _appRepository;

  _AppControllerBase(this._authController, this._cnpjsController, this._appRepository) {
    carregaTemaAbertura();
  }

  @observable
  bool temaDark = false;
  @observable
  String codTemaAtual = "1";

  @action
  void setCodTemaAtual(String novo, {bool gravar = true}) {
    codTemaAtual = novo;

    if (gravar) setTheme();
  }

  @action
  void setTemaDark(bool dark, {bool gravar = true}) {
    temaDark = dark;
    if (gravar) setTheme();
  }

  @action
  void setTheme() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('themeDark', temaDark ?? false);
      prefs.setString('codTheme', codTemaAtual ?? "1");
    });
  }

  @computed
  ThemeData get getTheme {
    var tm = MeusTemas.meusTemas.firstWhere(
      (t) => t.codigo == (codTemaAtual ?? "1"),
      orElse: () => MeusTemas.meusTemas[0],
    );

    return (temaDark ?? false) ? tm.darkTheme : tm.lightTheme;
  }

  void carregaTemaAbertura() async {
    var cd = await _getThemePrefCod();
    setCodTemaAtual(cd, gravar: false);
    var dk = await _getThemePrefDark();
    setTemaDark(dk, gravar: false);
  }

  Future<bool> _getThemePrefDark() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs == null) return false;

    var b = prefs.getBool('themeDark');
    return b ?? false;
  }

  Future<String> _getThemePrefCod() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs == null) return "1";

    var s = prefs.getString('codTheme');
    return s ?? "1";
  }

  ////
  DocumentReference get userAtualDocRef => _authController.userAtual.docRef;
  DocumentReference get cnpjAtivoDocRef => _cnpjsController.cnpjAtivo.docRef;
  String get userAtualDocId => _authController.userAtual.firebasebUser.uid;
  String get cnpjAtivoDocId => _cnpjsController.cnpjAtivo.docId;  // docId é o CNPJ
  ////


  Future<CnpjConfigsModel> getCnpjConfigs() async {
    //
    var map = await  _appRepository.getCnpjConfigs();
    
    return CnpjConfigsModel.fromJson(map);
    //
  }
}
