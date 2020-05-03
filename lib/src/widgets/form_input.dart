import 'package:flutter/material.dart';

class FormInput extends StatelessWidget {
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final Function(String) validator;
  final bool obscureText;
  final FocusNode focusNode;
  final bool readOnly;
  final initialValue;

  FormInput({
    this.hintText,
    this.obscureText = false,
    this.validator,
    this.prefixIcon,
    this.controller,
    this.focusNode,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        initialValue: initialValue,
        readOnly: readOnly,
        focusNode: focusNode,
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: hintText,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
