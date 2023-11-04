import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double width;
  final VoidCallback? onPressed;

  const CustomButton(
      {super.key, required this.text, this.onPressed, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: 40,
          width: width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(25),
            color: Colors.grey.shade200,
          ),
          child: Center(child: Text(text)),
        ),
      ),
    );
  }
}
