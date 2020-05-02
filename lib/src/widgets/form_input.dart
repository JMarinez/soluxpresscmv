import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final Function(String) validator;
  final bool obscureText;
  final FocusNode focusNode;
  final bool enabled;

  FormInput({
    this.hintText,
    this.obscureText,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    bool isPasswordField =
        obscureText == null ? false : (obscureText ? true : false);
    return TextFormField(
      enabled: enabled,
      focusNode: focusNode,
      controller: controller,
      validator: validator,
      obscureText: isPasswordField,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}
