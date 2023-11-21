import 'package:finder_app/constants/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final double width;
  final Future<void> Function()? onPressed;
  final Color btnColor;
  final Color textColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    required this.width,
    required this.btnColor,
    required this.textColor,
  }) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () async {
          if (!isLoading) {
            setState(() {
              isLoading = true;
            });
            if (widget.onPressed != null) {
              await widget.onPressed!();
            }
            setState(() {
              isLoading = false;
            });
          }
        },
        child: Container(
          height: 40,
          width: widget.width,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 0,
                offset: Offset(2, 2),
                spreadRadius: 0,
              )
            ],
            borderRadius: BorderRadius.circular(10),
            color: widget.btnColor,
          ),
          child: Center(
            child: isLoading
                ? CupertinoActivityIndicator(
                    color: AppColors.blue,
                  )
                : Text(
                    widget.text,
                    style: TextStyle(
                      color: widget.textColor,
                      letterSpacing: 0.50,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
