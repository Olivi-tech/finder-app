import 'package:flutter/material.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';

class SubscriptionPackage extends StatefulWidget {
  final String imageAsset;
  final String packageName;
  final String userDetails;
  final String pictures;
  final String statement;
  final String extraUser;
  final String price;
  final String savePercent;
  final Color textcolor;
  final bool isSelected;
  final VoidCallback onTap;

  const SubscriptionPackage({
    Key? key,
    required this.imageAsset,
    required this.packageName,
    required this.userDetails,
    required this.pictures,
    required this.statement,
    required this.extraUser,
    required this.price,
    required this.savePercent,
    required this.textcolor,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  _SubscriptionPackageState createState() => _SubscriptionPackageState();
}

class _SubscriptionPackageState extends State<SubscriptionPackage> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: widget.isSelected ? Colors.red : Colors.transparent,
              width: 0.9,
            ),
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
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 20,
                  bottom: 10,
                ),
                child: Row(
                  children: [
                    Image.asset(widget.imageAsset, width: 40, height: 30),
                    CustomText(
                      text: widget.packageName,
                      letterSpacing: 1,
                      color: AppColors.blue,
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                  ],
                ),
              ),
              packageDetailRow(AppImages.check, widget.userDetails),
              packageDetailRow(AppImages.check, widget.pictures),
              packageDetailRow(AppImages.check, widget.statement),
              packageDetailRow(AppImages.check, widget.extraUser),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 20,
                ),
                child: CustomText(
                  text: widget.price,
                  letterSpacing: 1,
                  color: AppColors.blue,
                  size: 22,
                  weight: FontWeight.w500,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  right: 10,
                  left: 20,
                  bottom: 10,
                ),
                child: CustomText(
                  text: widget.savePercent,
                  letterSpacing: 1,
                  color: widget.textcolor,
                  size: 14,
                  weight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget packageDetailRow(String imageAsset, String text) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 6,
        bottom: 10,
      ),
      child: Row(
        children: [
          Image.asset(imageAsset, width: 16, height: 16),
          CustomText(
            text: ' $text ',
            letterSpacing: 1,
            color: AppColors.black,
            size: 14,
            weight: FontWeight.w300,
          ),
        ],
      ),
    );
  }
}
