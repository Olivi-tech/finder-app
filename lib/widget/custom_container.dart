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
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: Container(
          width: 100,
          height: 100,
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
                width: 60,
                height: 50,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: widget.labelText,
                color: Colors.grey,
                size: 16,
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
