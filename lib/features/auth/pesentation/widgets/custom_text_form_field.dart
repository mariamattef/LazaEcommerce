import 'package:flutter/material.dart';
import 'package:laza_ecommerce/core/app_theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.isPassword,
    this.controller,
    required this.labelText,
    this.suffixIcon,
  });

  final bool? isPassword;
  final TextEditingController? controller;
  final String labelText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword ?? false,
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w500,
        color: AppTheme.textColor1,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: AppTheme.secondryColor,
        labelText: labelText,
        labelStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppTheme.subtextColor,
        ),
      ),
    );
  }
}
