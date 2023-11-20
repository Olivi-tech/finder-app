import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/model/item_model.dart';
import 'package:finder_app/screen/guest_screens.dart/guest_screens.dart';
import 'package:finder_app/screen/guest_screens.dart/profile_screen.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {
  List<ItemData> items = [];
  String name = '';

  Future<void> fetchItemData() async {
    final QuerySnapshot itemDataSnapshot = await FirebaseFirestore.instance
        .collection('companies')
        .doc('items')
        .collection('item_data')
        .get();

    final List<ItemData> fetchedItems =
        itemDataSnapshot.docs.map((doc) => ItemData.fromDocument(doc)).toList();

    setState(() {
      items = fetchedItems;
    });
  }

  Future<void> fetchUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          name = userSnapshot['name'];
        });
      }
    } catch (error) {}
  }

  String selectedCategory = '';

  List<ItemData> getFilteredItems(String category) {
    return items
        .where((item) =>
            item.name.toLowerCase().startsWith(category.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    fetchItemData();
    fetchUserData();
  }

  void showAllItems() {
    setState(() {
      selectedCategory = '';
    });
  }

  bool isLoggingOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: ProfileScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.all(7),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.green,
              ),
              child: Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 50,
        title: Row(
          children: [
            CustomText(
              text: 'Hi,',
              letterSpacing: 1,
              color: AppColors.green,
              size: 16,
              weight: FontWeight.w500,
            ),
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: name,
              letterSpacing: 1,
              color: Colors.black,
              size: 16,
              weight: FontWeight.w400,
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              try {
                setState(() {
                  isLoggingOut = true;
                });

                await FirebaseAuth.instance.signOut();

                Navigator.pushReplacementNamed(context, AppRoutes.login);
              } catch (e) {
                print("Error during logout: $e");
              } finally {
                setState(() {
                  isLoggingOut = false;
                });
              }
            },
            child: isLoggingOut
                ? CupertinoActivityIndicator(
                    color: Colors.red,
                  )
                : Icon(
                    Icons.logout,
                    color: AppColors.green,
                  ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Categories',
                      color: Colors.black,
                      letterSpacing: 1,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    GestureDetector(
                      onTap: showAllItems,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(
                              Icons.filter,
                              size: 14,
                              color: Colors.white,
                            ),
                            CustomText(
                              text: 'Show All',
                              size: 14,
                              weight: FontWeight.w500,
                              letterSpacing: 0.50,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    final images = [
                      AppImages.phoneIcon,
                      AppImages.keyIcon,
                      AppImages.walletIcon,
                      AppImages.laptopIcon,
                      AppImages.bagIcon,
                      AppImages.camIcon
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
                      padding: EdgeInsets.only(right: 8, bottom: 8, left: 4),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = labels[index];
                          });
                        },
                        child: CustomViewContainer(
                          labelText: labels[index],
                          imagePath: images[index],
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
                  left: 10,
                ),
                child: CustomText(
                  text: 'Recent Posts',
                  color: Colors.black,
                  letterSpacing: 1,
                  size: 20,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: CustomText(
                  text:
                      'We would like to inform you about some lost items that have been found. You can check them out here',
                  color: Colors.black,
                  size: 16,
                  weight: FontWeight.w300,
                ),
              ),
              SizedBox(
                height: 550,
                child: selectedCategory.isEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PostContainer(
                              imagePath: item.imageUrl,
                              containerText: item.name,
                              describtionText: item.description,
                              timeText: item.time,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: GuestItemDetailsPage(
                                      itemId: item.itemId,
                                      image_Url: item.imageUrl,
                                      name: item.name,
                                      description: item.description,
                                      color: item.color,
                                      quantity: item.quantity,
                                      time: item.time,
                                      companyName: item.companyName,
                                      address: item.companyAddress,
                                      category: item.category,
                                      brand: item.brand,
                                    ),
                                  ),
                                );
                              },
                              ontapcontact: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.guestContact);
                              },
                            ),
                          );
                        },
                      )
                    : getFilteredItems(selectedCategory).isEmpty
                        ? Center(child: Text('No result found'))
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount:
                                getFilteredItems(selectedCategory).length,
                            itemBuilder: (context, index) {
                              final item =
                                  getFilteredItems(selectedCategory)[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: PostContainer(
                                  imagePath: item.imageUrl,
                                  containerText: item.name,
                                  timeText: item.time,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: GuestItemDetailsPage(
                                          itemId: item.itemId,
                                          image_Url: item.imageUrl,
                                          name: item.name,
                                          description: item.description,
                                          color: item.color,
                                          quantity: item.quantity,
                                          time: item.time,
                                          companyName: item.companyName,
                                          address: item.companyAddress,
                                          category: item.category,
                                          brand: item.brand,
                                        ),
                                      ),
                                    );
                                  },
                                  describtionText: item.description,
                                  ontapcontact: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.guestContact);
                                  },
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
