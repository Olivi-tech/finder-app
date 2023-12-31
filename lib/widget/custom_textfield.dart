import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/utils.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? textInputFormatter;
  final bool isVisibleText;
  final Color fillColor;
  final double? width;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final IconData? iconData;
  final int maxLines;
  final TextInputType? keyboardType;
  final OnChangedValidator? validator;
  final bool readOnly;

  const CustomTextField({
    super.key,
    this.iconData,
    this.controller,
    this.textInputFormatter,
    this.suffixStyle,
    required this.hintText,
    required this.fillColor,
    this.isVisibleText = false,
    this.readOnly = false,
    this.hintStyle,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.width,
    this.onChanged,
  });

  @override
  build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        inputFormatters: textInputFormatter,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: validator,
        onChanged: onChanged,
        readOnly: readOnly,
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        obscureText: isVisibleText,
        obscuringCharacter: '●',
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          fillColor: fillColor,
          suffixIcon: suffixIcon,
          suffixStyle: suffixStyle,
          prefixIcon: iconData != null ? Icon(iconData) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.5,
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
bool isValidEmail(String input) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegex.hasMatch(input);
  }