import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.textController, this.keyboarType,
  });

  final Key fieldKey;
  final TextEditingController textController;
  final String hintText;
  final String labelText;
  final String helperText;
  final TextInputType keyboarType;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() =>  _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // print('desenehei poassword field');
    return  TextFormField(
      key: widget.fieldKey,
      controller: widget.textController,
      obscureText: _obscureText,
      keyboardType: widget.keyboarType,
      //maxLength: 8,
      onSaved: widget.onSaved,
      validator: widget.validator,
      //onFieldSubmitted: widget.onFieldSubmitted,
      decoration:  InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: Icon(Icons.vpn_key),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon:  GestureDetector(
          onTap: () => setState(() => _obscureText = !_obscureText),
          child:  Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: _obscureText ? Colors.grey : Colors.red,
          ),
        ),
      ),
    );
  }
}
