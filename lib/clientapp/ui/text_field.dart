import 'package:flutter/material.dart';

/// Primary text form field.
class PrimaryTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String initialValue;
  final String hintText;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final Function validator;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onChanged;
  final bool enabled;

  PrimaryTextFormField({
    this.controller,
    this.initialValue,
    this.hintText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled = true,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
    );

    return TextFormField(
      controller: controller,
      decoration: new InputDecoration(
        enabledBorder: border,
        disabledBorder: border,
        focusedBorder: border,
        errorBorder: border,
        focusedErrorBorder: border,
        filled: true,
        hintStyle: new TextStyle(color: const Color(0x88707070)),
        hintText: hintText,
        fillColor: const Color(0xFFEEEEEE),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
      initialValue: initialValue,
      textAlign: TextAlign.center,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      enabled: enabled,
    );
  }
}
