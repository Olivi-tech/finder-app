import 'package:finder_app/constants/app_colors.dart';
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
  final Color? fillColor;
  final double? width;
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;
  final IconData? iconData;
  final int maxLines;
  final TextInputType? keyboardType;
  final OnChangedValidator? validator;
  final bool readOnly;
  final bool obscureText;

  const CustomTextField({
    super.key,
    this.iconData,
    this.controller,
    this.textInputFormatter,
    this.suffixStyle,
    required this.hintText,
    this.fillColor,
    this.isVisibleText = false,
    this.readOnly = false,
    this.hintStyle,
    this.suffixIcon,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
    this.width,
    this.onChanged,
    required this.obscureText,
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
        obscureText: obscureText,
        obscuringCharacter: '●',
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: hintStyle,
          fillColor: Colors.transparent,
          suffixIcon: suffixIcon,
          suffixStyle: suffixStyle,
          prefixIcon: iconData != null ? Icon(iconData) : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.7, color: AppColors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 0.7, color: AppColors.grey),
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

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?[0-9]+$');
  return regex.hasMatch(phoneNumber);
}

bool isValidCRNumber(String input) {
  final RegExp regex = RegExp(r'^\+?[0-9]+$');
  return regex.hasMatch(input);
}

bool isValidName(String name) {
  final RegExp regex = RegExp(r'^[a-zA-Z ]+$');
  final bool hasValidLength = name.length >= 2 && name.length <= 50;
  return regex.hasMatch(name) && hasValidLength;
}

bool isValidAddress(String address) {
  final RegExp regex = RegExp(
    r'^[a-zA-Z0-9@#/*&.,()"\s-]+$',
  );
  final bool hasValidLength = address.length <= 250;
  return regex.hasMatch(address) && hasValidLength;
}

bool isValidCreditCard(String creditCardNumber) {
  final RegExp regex = RegExp(r'^[0-9]{16}$');
  return regex.hasMatch(creditCardNumber);
}

bool isValidZipCode(String zipCode) {
  final RegExp regex = RegExp(r'^[0-9]{4}$');
  return regex.hasMatch(zipCode);
}
