// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeBase, Store {
  Computed<String> _$tituloTabComputed;

  @override
  String get tituloTab => (_$tituloTabComputed ??=
          Computed<String>(() => super.tituloTab, name: '_HomeBase.tituloTab'))
      .value;

  final _$tabActiveAtom = Atom(name: '_HomeBase.tabActive');

  @override
  int get tabActive {
    _$tabActiveAtom.reportRead();
    return super.tabActive;
  }

  @override
  set tabActive(int value) {
    _$tabActiveAtom.reportWrite(value, super.tabActive, () {
      super.tabActive = value;
    });
  }

  final _$_HomeBaseActionController = ActionController(name: '_HomeBase');

  @override
  void setTabActive(int tab) {
    final _$actionInfo =
        _$_HomeBaseActionController.startAction(name: '_HomeBase.setTabActive');
    try {
      return super.setTabActive(tab);
    } finally {
      _$_HomeBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tabActive: ${tabActive},
tituloTab: ${tituloTab}
    ''';
  }
}
