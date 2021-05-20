import 'package:flutter/material.dart';

class MyConst {
  static String cnpjEmpresaFixa = '00801558557';
  static bool permiteSemLogar = true;
  static List<String> formatacaoDataHora = [
    'dd',
    '/',
    'mm',
    '/',
    'yyyy',
    ' ',
    'HH',
    ':',
    'nn'
  ];
  static List<String> formatacaoData = ['dd', '/', 'mm', '/', 'yyyy'];
  static BoxConstraints boxConstraints =
      BoxConstraints(maxWidth: 500, minWidth: 230);
}
