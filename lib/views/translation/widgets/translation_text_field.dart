// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:translator_app/core/theme/app_palette.dart';

class TranslationTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final void Function(String value)? onChanged;
  final bool enabled;
  final String? Function(String?)? validator;

  const TranslationTextField({
    super.key,
    required this.controller,
    this.hintText = "",
    this.maxLength = 2300,
    this.onChanged,
    this.enabled = true,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      constraints: const BoxConstraints(minHeight: 180),
      decoration: BoxDecoration(
        color: AppPalette.fillColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            enabled: enabled,
            onChanged: onChanged,
            controller: controller,
            maxLength: maxLength,
            maxLines: null,
            style: const TextStyle(fontSize: 14),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              border: InputBorder.none,
              counterText: "",
            ),
            validator: validator,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const SizedBox(
                height: 5,
              ),
              Text(
                '${controller.text.length}/$maxLength',
                style: const TextStyle(
                  color: AppPalette.greyColor,
                  fontSize: 13,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
