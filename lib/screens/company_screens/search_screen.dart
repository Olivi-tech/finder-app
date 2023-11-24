import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/screens/company_screens/item_details_screen.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/model.dart';

class SearchPostScreen extends StatefulWidget {
  const SearchPostScreen({super.key});

  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  TextEditingController searchController = TextEditingController();
  late CollectionReference collection;
  List<ItemData> items = [];
  String companyName = '';
  String companyAddress = '';
  String companyPhoneNo = '';
  String companyCountry = '';
  late List<ItemData> filteredItems = [];

  Future<void> fetchCompanyData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
          .collection(AppText.userDataCollection)
          .doc(uid)
          .get();

      if (companySnapshot.exists) {
        setState(() {
          companyName = companySnapshot[AppText.name];
          companyAddress = companySnapshot[AppText.address];
          companyPhoneNo = companySnapshot[AppText.phoneNumber];
          companyCountry = companySnapshot[AppText.country];
        });
      }
    } catch (error) {}
  }

  //
  // Future<void> fetchLatestItemData() async {
  //   final QuerySnapshot itemDataSnapshot = await FirebaseFirestore.instance
  //       .collection(AppText.itemCollection)
  //       .get();
  //
  //   final List<ItemData> fetchedItems = itemDataSnapshot.docs.map((doc) {
  //     return ItemData.fromDocument(doc.id, doc);
  //   }).toList();
  //
  //   setState(() {
  //     items = fetchedItems;
  //   });
  // }

  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Future<void> _deleteItem(String documentId, BuildContext context) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('companies')
  //         .doc('items')
  //         .collection('item_data')
  //         .doc(documentId)
  //         .delete();
  //     setState(() {
  //       items.removeWhere((item) => item.documentId == documentId);
  //
  //       filteredItems = items;
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: CustomText(
  //           text: 'Item deleted successfully.',
  //           color: Colors.white,
  //         ),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //   } catch (error) {
  //     print('Error deleting item: $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // fetchLatestItemData();
    fetchCompanyData();

    collection = FirebaseFirestore.instance.collection(AppText.itemCollection);
    filteredItems = items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        backgroundColor: AppColors.green,
        location: companyAddress,
        name: companyName,
        imagepath: AppImages.companylogo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 14, top: 10, bottom: 10),
              child: CustomText(
                text: 'Search Posts',
                color: AppColors.black,
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w500,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 14, top: 10, bottom: 20, right: 14),
              child: CustomSearchField(
                controller: searchController,
                hintText: 'Search',
                onChanged: (query) {
                  _filterItems(query);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 10),
              child: CustomText(
                text: 'Recent Posts',
                color: AppColors.black,
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w500,
              ),
            ),
            StreamBuilder(
              stream: collection.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs;
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: GestureDetector(
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      CustomText(
                                        letterSpacing: 1,
                                        weight: FontWeight.w600,
                                        color: AppColors.red,
                                        text: 'Delete',
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(
                                        Icons.warning_amber,
                                        color: AppColors.red,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                  content: const Text(
                                      'Are you sure you want to delete this item?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CustomText(
                                        letterSpacing: 1,
                                        text: 'Cancel',
                                        color: AppColors.black,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        //   _deleteItem(item.documentId, context);
                                        Navigator.of(context).pop();
                                      },
                                      child: CustomText(
                                        letterSpacing: 1,
                                        color: AppColors.red,
                                        text: 'Delete',
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: ImageContainer(
                            imagePath: data[index][AppText.image],
                            containerText: data[index][AppText.name],
                            locationText: companyName,
                            timeText: data[index][AppText.time],
                            dateText: formatDateWithoutTime(
                                (data[index][AppText.date] as Timestamp)
                                    .toDate()),
                            onTap: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ItemDetailsPage(
                                    data: data[index],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String formatDateWithoutTime(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
