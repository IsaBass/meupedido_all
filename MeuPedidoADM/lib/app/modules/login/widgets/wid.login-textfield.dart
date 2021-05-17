import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  final Key fieldKey;
  final TextEditingController textController;
  final TextInputType keyboarType;
  final IconData iconData;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldValidator<String> validator;

  const LoginTextField(
      {this.fieldKey,
      this.textController,
      this.keyboarType,
      this.hintText,
      this.labelText,
      this.helperText,
      this.validator, this.iconData});

  @override
  _LoginTextFieldState createState() =>  _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      controller: widget.textController,
      keyboardType: widget.keyboarType,
      decoration:  InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: Icon(widget.iconData),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
      ),
      validator: widget.validator,
    );
  }
}
