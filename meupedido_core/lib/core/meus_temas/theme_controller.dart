import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'meus_temas.dart';
part 'theme_controller.g.dart';

class ThemeController = _ThemeControllerBase with _$ThemeController;

abstract class _ThemeControllerBase with Store {
  //
  //
  _ThemeControllerBase() {
    carregaTemaAbertura();
  }
  //

  @observable
  bool temaDark = false;
  @observable
  String codTemaAtual = "1";

  // SECAO THEMA //

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
}
