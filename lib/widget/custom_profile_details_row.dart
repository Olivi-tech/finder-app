import 'package:flutter/material.dart';

class CustomUserInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle labelStyle;
  final TextStyle valueStyle;

  const CustomUserInfoRow({
    Key? key,
    required this.label,
    required this.value,
    this.labelStyle = const TextStyle(fontSize: 14),
    this.valueStyle = const TextStyle(fontSize: 15, color: Colors.blue),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: labelStyle,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: valueStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
