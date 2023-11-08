import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';
import '../../constant/app_colors.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  void handleNavigation(int selectedIndex) {
    setState(() {
      currentIndex = selectedIndex;
    });
    switch (selectedIndex) {
      case 0:
        //  Navigator.pushNamed(context, AppRoutes.homePage);
        break;
      case 1:
        Navigator.pushNamed(context, AppRoutes.itemAdd);
        break;
      case 2:
        //  Navigator.pushNamed(context, AppRoutes.homePage);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        getSelectedIndex: handleNavigation,
      ),
      appBar: AppBarCustom(
        backgroundColor: AppColors.green,
        location: 'Pakistan',
        name: 'Base Camp Resort',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(14.0),
                child: CustomSearchField(hintText: 'Search items'),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                ),
                child: CustomText(
                  text: 'Categories',
                  color: Colors.black,
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final images = [
                      AppImages.phoneicon,
                      AppImages.keyicon,
                      AppImages.walleticon,
                      AppImages.laptopicon,
                      AppImages.bagicon,
                      AppImages.camicon
                    ];
                    final labels = [
                      'Phone',
                      'Key',
                      'Wallet',
                      'Laptop',
                      'Bag',
                      'Camera'
                    ];

                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomViewContainer(
                        labelText: labels[index],
                        imagePath: images[index],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 14,
                ),
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
              ImageContainer(
                  imagePath: AppImages.phoneImge,
                  containerText: 'Iphone 11',
                  locationText: 'Base Camp Resort',
                  timeText: '15 mints ago',
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.itemDetails);
                  }),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
