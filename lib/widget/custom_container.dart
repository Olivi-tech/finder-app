import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class CustomViewContainer extends StatefulWidget {
  final String labelText;
  final String imagePath;

  const CustomViewContainer({
    Key? key,
    required this.labelText,
    required this.imagePath,
  }) : super(key: key);

  @override
  CustomViewContainerState createState() => CustomViewContainerState();
}

class CustomViewContainerState extends State<CustomViewContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 2, right: 2),
        child: Container(
          width: 70,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                widget.imagePath,
                width: 30,
                height: 25,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: widget.labelText,
                color: Colors.grey,
                size: 12,
                weight: FontWeight.w500,
                letterSpacing: 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatefulWidget {
  final String labelText;
  final IconData iconData;
  final Color color;

  const CustomContainer({
    Key? key,
    required this.labelText,
    required this.iconData,
    required this.color,
  }) : super(key: key);

  @override
  CustomContainerState createState() => CustomContainerState();
}

class CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 130,
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                widget.iconData,
                color: widget.color,
                size: 28,
              ),
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: widget.labelText,
                color: Colors.black,
                size: 14,
                weight: FontWeight.w400,
                letterSpacing: 0.50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
