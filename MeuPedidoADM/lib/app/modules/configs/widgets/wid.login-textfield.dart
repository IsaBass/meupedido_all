import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final Key fieldKey;
  final TextEditingController textController;
  final TextInputType keyboarType;
  final IconData iconData;
  final String hintText;
  final String labelText;
  final String helperText;
  final bool enabled;
  final FormFieldValidator<String> validator;

  const MyTextField({
    this.fieldKey,
    this.textController,
    this.keyboarType,
    this.hintText,
    this.labelText,
    this.helperText,
    this.validator,
    this.iconData,
    this.enabled = true,
  });

  @override
  _MyTextFieldState createState() => new _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      enabled: widget.enabled,
      controller: widget.textController,
      keyboardType: widget.keyboarType,
      decoration: new InputDecoration(
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
