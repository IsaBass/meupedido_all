
  import 'package:flutter/material.dart';

InputDecoration inputDecoration({String hintText}) {
    return InputDecoration(
      hintText: hintText,
      errorBorder: _borderErro(),
      focusedBorder: _borderFocused(),
      border: _borderBorder(),
      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
    );
  }

  OutlineInputBorder _borderBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }

  OutlineInputBorder _borderErro() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }

  OutlineInputBorder _borderFocused() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(10),
        right: Radius.circular(10),
      ),
    );
  }

