// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.item_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CartItemModel on _CartItemModelBase, Store {
  Computed<double> _$vlrTotComputed;

  @override
  double get vlrTot =>
      (_$vlrTotComputed ??= Computed<double>(() => super.vlrTot,
              name: '_CartItemModelBase.vlrTot'))
          .value;
  Computed<double> _$vlrAdicsComputed;

  @override
  double get vlrAdics =>
      (_$vlrAdicsComputed ??= Computed<double>(() => super.vlrAdics,
              name: '_CartItemModelBase.vlrAdics'))
          .value;

  final _$quantAtom = Atom(name: '_CartItemModelBase.quant');

  @override
  double get quant {
    _$quantAtom.reportRead();
    return super.quant;
  }

  @override
  set quant(double value) {
    _$quantAtom.reportWrite(value, super.quant, () {
      super.quant = value;
    });
  }

  final _$_CartItemModelBaseActionController =
      ActionController(name: '_CartItemModelBase');

  @override
  void incrementQtd() {
    final _$actionInfo = _$_CartItemModelBaseActionController.startAction(
        name: '_CartItemModelBase.incrementQtd');
    try {
      return super.incrementQtd();
    } finally {
      _$_CartItemModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void decrementQtd() {
    final _$actionInfo = _$_CartItemModelBaseActionController.startAction(
        name: '_CartItemModelBase.decrementQtd');
    try {
      return super.decrementQtd();
    } finally {
      _$_CartItemModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quant: ${quant},
vlrTot: ${vlrTot},
vlrAdics: ${vlrAdics}
    ''';
  }
}
