import 'package:flutter/material.dart';

Widget exibeCarregandoLinha({bool isLoading = true} ) {
  return Container(
    child: isLoading
        ? LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        : Container(height: 6),
  );
}

Widget exibeCarregandoCircular({bool isLoading = true} ) {
  return Container(
    child: isLoading
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          )
        : Container(height: 0),
  );
}
