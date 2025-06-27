import 'package:flutter/material.dart';

import '../const/app_colors.dart';

class CustomeTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;

  final Color backgoundColor;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomeTextForm({
    super.key,
    this.controller,
    required this.validator,
    required this.onChanged,
    required this.hintText,
    this.backgoundColor = AppColors.textfeildBackgroundColor,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: backgoundColor,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
