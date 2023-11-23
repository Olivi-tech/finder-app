import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int selectedPackageIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(AppImages.subcribtion, width: 50, height: 50),
                SizedBox(height: 20),
                const CustomText(
                  text: 'Subscription Plans',
                  letterSpacing: 1,
                  color: AppColors.black,
                  size: 28,
                  weight: FontWeight.w500,
                ),
              ],
            ),
            SizedBox(height: 20),
            CustomText(
              text:
                  'Purchase Package that suits you best and elevate your journey with us.',
              size: 16,
              weight: FontWeight.w300,
              letterSpacing: 0.50,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                SubscriptionPackage(
                  imageAsset: AppImages.basic,
                  packageName: 'Basic',
                  userDetails: '1 User',
                  pictures: '10 Pictures',
                  statement: 'Monthly statement',
                  extraUser: 'Extra user',
                  price: '\$70',
                  savePercent: 'Save Upto 30%',
                  textcolor: AppColors.red,
                  isSelected: selectedPackageIndex == 0,
                  onTap: () {
                    setState(() {
                      selectedPackageIndex = 0;
                    });
                  },
                ),
                SizedBox(width: 10),
                SubscriptionPackage(
                  imageAsset: AppImages.permium,
                  packageName: 'Premium',
                  userDetails: '1-10 User',
                  pictures: '10 Pictures',
                  statement: 'Weekly statement',
                  extraUser: 'Extra user 100\$',
                  price: '\$70',
                  savePercent: 'Save Upto 30%',
                  textcolor: AppColors.red,
                  isSelected: selectedPackageIndex == 1,
                  onTap: () {
                    setState(() {
                      selectedPackageIndex = 1;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 100),
            CustomButton(
              btnColor: AppColors.green,
              textColor: Colors.white,
              text: 'Buy now',
              onPressed: () async {},
              width: MediaQuery.sizeOf(context).width,
            ),
          ],
        ),
      ),
    );
  }
}
