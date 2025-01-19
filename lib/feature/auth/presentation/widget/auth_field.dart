import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? isObscureTxt;

  const AuthField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscureTxt = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureTxt!,
      decoration: InputDecoration(hintText: hintText),
      validator: (val) {
        if (val!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
