import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/model/item_model.dart';
import 'package:finder_app/screens/guest_screens.dart/item_details_screen.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {
  List<ItemData> items = [];
  String name = '';

  TextEditingController searchController = TextEditingController();
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
            item.category.toLowerCase().startsWith(category.toLowerCase()))
        .toList();
  }

  late List<ItemData> filteredItems = [];
  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItemData();
    fetchUserData();
    filteredItems = items;
  }

  void showAllItems() {
    setState(() {
      selectedCategory = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.all(7),
          child: Icon(
            Icons.person,
            color: AppColors.grey,
          ),
        ),
        leadingWidth: 30,
        title: Row(
          children: [
            CustomText(
              text: 'Hi,',
              letterSpacing: 1,
              color: AppColors.blue,
              size: 16,
              weight: FontWeight.w500,
            ),
            SizedBox(
              width: 10,
            ),
            CustomText(
              text: name,
              letterSpacing: 1,
              color: AppColors.black,
              size: 16,
              weight: FontWeight.w400,
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.guestSettingScreen);
            },
            child: Icon(
              Icons.settings,
              color: AppColors.grey,
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
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 5),
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Find your items here',
                            color: AppColors.black,
                            letterSpacing: 1,
                            size: 22,
                            weight: FontWeight.w600,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomText(
                            text:
                                'We would like to inform you about\nsome lost items that have been \nfound. You can check them out below.',
                            color: AppColors.black,
                            size: 12,
                            weight: FontWeight.w300,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(AppImages.companylogo),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 5, top: 10, bottom: 20, right: 5),
                child: CustomSearchField(
                  controller: searchController,
                  hintText: 'Search',
                  onChanged: (query) {
                    _filterItems(query);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Categories',
                      letterSpacing: 1,
                      size: 20,
                      weight: FontWeight.w600,
                    ),
                    GestureDetector(
                      onTap: showAllItems,
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.blue,
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
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    final images = [
                      AppImages.electronic,
                      AppImages.accessories,
                      AppImages.bag,
                      AppImages.sports,
                      AppImages.keyIcon,
                      AppImages.toy,
                      AppImages.books,
                      AppImages.clothes,
                      AppImages.medicine,
                    ];
                    final labels = [
                      'Electronic',
                      'Accessories',
                      'Bag',
                      'Sport',
                      'key',
                      'Toy',
                      'Book',
                      'Cloth',
                      'Medicine',
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
                  color: AppColors.black,
                  letterSpacing: 1,
                  size: 20,
                  weight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 550,
                child: selectedCategory.isEmpty
                    ? (searchController.text.isEmpty
                        ? (items.isNotEmpty
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
                                      locationText: item.companyAddress,
                                      dateText:
                                          formatDateWithoutTime(item.date),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
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
                                              companyCountry:
                                                  item.companyCountry,
                                              phoneNo: item.companyPhone,
                                              date: item.date,
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
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                padding: const EdgeInsets.only(top: 100),
                                  child: Text('No result found'),
                                )))
                        : (filteredItems.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: filteredItems.length,
                                itemBuilder: (context, index) {
                                  final item = filteredItems[index];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: PostContainer(
                                      imagePath: item.imageUrl,
                                      containerText: item.name,
                                      describtionText: item.description,
                                      timeText: item.time,
                                      locationText: item.companyAddress,
                                      dateText:
                                          formatDateWithoutTime(item.date),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
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
                                              companyCountry:
                                                  item.companyCountry,
                                              phoneNo: item.companyPhone,
                                              date: item.date,
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
                            : Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                 padding: const EdgeInsets.only(top: 100),
                                  child: Text('No result found'),
                                ))))
                    : getFilteredItems(selectedCategory).isEmpty
                        ? Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Text('No result found'),
                            ))
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
                                  locationText: item.companyAddress,
                                  dateText: formatDateWithoutTime(item.date),
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
                                          companyCountry: item.companyCountry,
                                          phoneNo: item.companyPhone,
                                          date: item.date,
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

String formatDateWithoutTime(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
