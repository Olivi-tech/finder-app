import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/provider/bottom_navigation_provider.dart';
import 'package:finder_app/screen/company_screens/add_item_screen.dart';
import 'package:finder_app/screen/company_screens/item_details_screen.dart';
import 'package:finder_app/widget/custom_Image_container.dart';
import 'package:finder_app/widget/custom_bottom_navigationbar.dart';
import 'package:finder_app/widget/custom_container.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../constant/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late BottomNavigationProvider _navigationProvider;

  @override
  void initState() {
    _navigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        getSelectedIndex: (currentIndex) {
          _navigationProvider.selectedIndex = currentIndex;
        },
      ),
      body: Consumer<BottomNavigationProvider>(
        builder: (context, index, child) => <Widget>[
          const HomeScreen(),
          const AddItemScreen(),
          const HomeScreen(),
        ][index.selectedIndex],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        backgroundColor: AppColors.darkGreen,
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
                  weight: FontWeight.w500,
                  size: 18,
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
                    final icons = [
                      Icons.phone_iphone,
                      Icons.key,
                      Icons.shopping_bag,
                      Icons.laptop,
                      Icons.wallet,
                      Icons.camera,
                    ];
                    final labels = [
                      'Phone',
                      'Key',
                      'Bag',
                      'Laptop',
                      'Wallet',
                      'Camera'
                    ];

                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: CustomViewContainer(
                        labelText: labels[index],
                        icon: Icon(
                          icons[index],
                          color: AppColors.darkGreen,
                          size: 36,
                        ),
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
                  weight: FontWeight.w500,
                  size: 18,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemDetailsPage(
                            containerText: 'Iphone 11',
                            timeText: '15 mints ago',
                            imagePath: AppImages.phoneImge,
                            locationText: 'Base Camp Resort, lahore',
                          ),
                        ));
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
