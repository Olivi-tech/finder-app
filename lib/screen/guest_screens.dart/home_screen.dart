import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/custom_Image_container.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: CircleAvatar(
            backgroundImage: AssetImage(AppImages.boypic),
          ),
        ),
        leadingWidth: 50,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Hi,',
              letterSpacing: 1,
              color: Colors.black,
              size: 12,
              weight: FontWeight.w300,
            ),
            const CustomText(
              text: 'Denez',
              letterSpacing: 1,
              color: Colors.black,
              size: 12,
              weight: FontWeight.w600,
            ),
          ],
        ),
        actions: [
          // const Icon( Icons.delete, color: Colors.red, size: 28, ),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: CustomText(
                  text: 'Recent Posts',
                  color: Colors.black,
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              PostContainer(
                imagePath: AppImages.phoneImge,
                containerText: 'Iphone 11',
                timeText: '15 mints ago',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.guestItemDetails);
                },
                describtionText:
                    'We found an iPhone 11. It appears to be in good condition and is locked, so We cant access any contact information to return it to its owner.',
                ontapcontact: () {
                  Navigator.pushNamed(context, AppRoutes.guestContact);
                },
              ),
              SizedBox(
                height: 10,
              ),
              PostContainer(
                imagePath: AppImages.walletpic,
                containerText: 'Wallet',
                timeText: '1 hr ago',
                onTap: () {},
                describtionText:
                    'We found an Wallet. It appears to be in good condition and not have ID cards, so We cant access any contact information to return it to its owner.',
                ontapcontact: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
