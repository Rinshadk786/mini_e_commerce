import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    required TextEditingController emailController,
    required this.validator,
    required this.hintText,
  }) : _emailController = emailController;

  final String? Function(String?) validator;
  final TextEditingController _emailController;
  final bool obscureText;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).colorScheme;
    return TextFormField(
      obscureText: obscureText,
      decoration: InputDecoration(
        fillColor: appColors.tertiary,
        filled: true,
        labelText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      controller: _emailController,
      validator: validator,
    );
  }
}
