import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final double? size;
  final String text;
  final int maxLine;
  final Color? color;
  final FontWeight? weight;
  final double? height;
  final TextOverflow? overflow;
  final double? letterSpacing;
  final TextAlign? align;

  const CustomText({
    Key? key,
    this.color,
    this.maxLine = 1,
    this.align,
    this.size,
    this.weight,
    this.overflow,
    required this.text,
    this.height,
    this.letterSpacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      textAlign: align,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: weight,
        height: height,
      ),
    );
  }
}
