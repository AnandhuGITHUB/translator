import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final bool autoFocus;
  final bool? isValidationNeed;
  final String hintText;
  final String? label;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Widget? prefixIcon;
  final String? Function(String? value)? validator;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  const AppTextField({
    super.key,
    this.isValidationNeed = true,
    required this.hintText,
    this.label,
    required this.controller,
    this.isObscureText = false,
    this.textInputType,
    this.textInputAction = TextInputAction.done,
    this.prefixIcon,
    this.validator,
    this.suffixIcon,
    this.inputFormatters,
    this.readOnly = false,
    this.onTap,
    this.textCapitalization,
    this.onChanged,
    this.autoFocus = false,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      enableInteractiveSelection: false,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      obscureText: isObscureText,
      controller: controller,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      ),
      maxLines: maxLines ?? 1,
      onChanged: onChanged,
      validator: (value) {
        if (isValidationNeed == true) {
          if (value == null || value.isEmpty) {
            return '$hintText is missing';
          }
          if (validator != null) {
            return validator!(value);
          }
        } else {
          return null;
        }
        return null;
      },
      onTap: onTap,
    );
  }
}
