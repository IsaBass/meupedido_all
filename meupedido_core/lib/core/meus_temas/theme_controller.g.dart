// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThemeController on _ThemeControllerBase, Store {
  Computed<ThemeData> _$getThemeComputed;

  @override
  ThemeData get getTheme =>
      (_$getThemeComputed ??= Computed<ThemeData>(() => super.getTheme,
              name: '_ThemeControllerBase.getTheme'))
          .value;

  final _$temaDarkAtom = Atom(name: '_ThemeControllerBase.temaDark');

  @override
  bool get temaDark {
    _$temaDarkAtom.reportRead();
    return super.temaDark;
  }

  @override
  set temaDark(bool value) {
    _$temaDarkAtom.reportWrite(value, super.temaDark, () {
      super.temaDark = value;
    });
  }

  final _$codTemaAtualAtom = Atom(name: '_ThemeControllerBase.codTemaAtual');

  @override
  String get codTemaAtual {
    _$codTemaAtualAtom.reportRead();
    return super.codTemaAtual;
  }

  @override
  set codTemaAtual(String value) {
    _$codTemaAtualAtom.reportWrite(value, super.codTemaAtual, () {
      super.codTemaAtual = value;
    });
  }

  final _$_ThemeControllerBaseActionController =
      ActionController(name: '_ThemeControllerBase');

  @override
  void setCodTemaAtual(String novo, {bool gravar = true}) {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
        name: '_ThemeControllerBase.setCodTemaAtual');
    try {
      return super.setCodTemaAtual(novo, gravar: gravar);
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTemaDark(bool dark, {bool gravar = true}) {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
        name: '_ThemeControllerBase.setTemaDark');
    try {
      return super.setTemaDark(dark, gravar: gravar);
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTheme() {
    final _$actionInfo = _$_ThemeControllerBaseActionController.startAction(
        name: '_ThemeControllerBase.setTheme');
    try {
      return super.setTheme();
    } finally {
      _$_ThemeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
temaDark: ${temaDark},
codTemaAtual: ${codTemaAtual},
getTheme: ${getTheme}
    ''';
  }
}
