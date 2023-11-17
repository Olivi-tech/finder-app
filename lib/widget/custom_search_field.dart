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
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        prefixIcon: Icon(Icons.search, color: Colors.grey),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: Colors.transparent),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
