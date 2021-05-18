import 'package:flutter/material.dart';

class DefaultTextFormField extends StatefulWidget {
  final Key fieldKey;
  final TextEditingController textController;
  final TextInputType keyboarType;
  final IconData iconData;
  final String hintText;
  final String labelText;
  final String helperText;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String> validator;
  final Function(String) onchanged;
  final Function(String) onsubmitted;
  final List<TextInputFormatter> inputFormatters;

  const DefaultTextFormField({
    this.fieldKey,
    this.textController,
    this.keyboarType,
    this.hintText,
    this.labelText,
    this.helperText,
    this.validator,
    this.onchanged,
    this.onsubmitted,
    this.iconData,
    this.enabled = true,
    this.inputFormatters = [],
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  _DefaultTextFormFieldState createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.inputFormatters,
      textCapitalization: widget.textCapitalization,
      enabled: widget.enabled,
      key: widget.fieldKey,
      controller: widget.textController,
      keyboardType: widget.keyboarType,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        filled: true,
        icon: widget.iconData != null ? Icon(widget.iconData) : null,
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
      ),
      validator: widget.validator,
      onChanged: widget.onchanged,
      onFieldSubmitted: widget.onsubmitted,
    );
  }
}
