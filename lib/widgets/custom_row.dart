import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  final String label;
  final dynamic value;

  const CustomRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              letterSpacing: 1,
              size: 18,
              weight: FontWeight.w500,
              color: AppColors.black,
              text: label,
            ),
            SizedBox(width: 10),
            CustomText(
              letterSpacing: 1,
              size: 16,
              weight: FontWeight.w400,
              color: AppColors.black,
              text: value,
            ),
          ],
        ),
        SizedBox(height: 10),
        Divider(color: Colors.grey),
        SizedBox(height: 10),
      ],
    );
  }
}
