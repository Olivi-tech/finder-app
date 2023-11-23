import 'package:finder_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchField extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  const CustomSearchField({
    Key? key,
    required this.hintText,
    this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: Icon(Icons.search, color: AppColors.grey),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.grey, width: 0.7),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.grey, width: 0.7),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: AppColors.grey, width: 0.7),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
