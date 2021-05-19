import 'package:flutter/material.dart';

void mySnackBar(BuildContext context,
    {int miliseconds = 800,
    String texto = 'Executado',
    Color color = const Color(0xFFBF3600) //Colors.deepOrange[900]
    }) {
  ///

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(texto),
    backgroundColor: color,
    duration: Duration(milliseconds: miliseconds),
  ));
}
