import 'package:flutter/material.dart';

import 'package:union/core/themes/palette.dart';

class CustomFormField extends StatelessWidget {
  final Icon icon;
  final String hint;
  final String label;
  final bool obscure;
  final Iterable<String> autofillHints;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    required this.icon,
    required this.hint,
    required this.label,
    this.obscure = false,
    this.autofillHints = const [],
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? labelSmall = Theme.of(context).textTheme.labelSmall;

    return TextFormField(
      controller: controller,
      obscureText: obscure,
      autofillHints: autofillHints,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: label,
        hintText: hint,
      ),
      style: labelSmall?.copyWith(color: Palette.textDescriptionColor),
      validator: validator,
    );
  }
}
