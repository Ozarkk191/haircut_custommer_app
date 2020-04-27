import 'package:flutter/material.dart';

class BigRoundTextField extends StatelessWidget {
  final String initialValue;
  final String hintText;
  final String errorText;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final Function validator;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final Function onChanged;
  final bool enabled;
  final double marginTop;

  const BigRoundTextField({
    Key key,
    this.initialValue,
    this.hintText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.enabled,
    this.errorText,
    this.marginTop = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.transparent, width: 0.0),
      borderRadius: const BorderRadius.all(const Radius.circular(30.0)),
    );
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      margin: EdgeInsets.only(top: marginTop),
      child: TextFormField(
        decoration: new InputDecoration(
          enabledBorder: border,
          disabledBorder: border,
          focusedBorder: border,
          errorBorder: border,
          focusedErrorBorder: border,
          filled: true,
          hintStyle: new TextStyle(color: const Color(0x88707070)),
          hintText: hintText,
          errorText: errorText,
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
      ),
    );
  }
}
