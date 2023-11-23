import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/screens/company_screens/item_details_screen.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';

class SearchPostScreen extends StatefulWidget {
  const SearchPostScreen({super.key});

  @override
  State<SearchPostScreen> createState() => _SearchPostScreenState();
}

class _SearchPostScreenState extends State<SearchPostScreen> {
  List<ItemData> items = [];
  String companyName = '';
  String companyAddress = '';
  String companyPhoneNo = '';
  String companyCountry = '';
  late List<ItemData> filteredItems = [];
  TextEditingController searchController = TextEditingController();
  Future<void> fetchCompanyData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
          .collection('companies')
          .doc(uid)
          .get();

      if (companySnapshot.exists) {
        setState(() {
          companyName = companySnapshot['name'];
          companyAddress = companySnapshot['address'];
          companyPhoneNo = companySnapshot['phoneNo'];
          companyCountry = companySnapshot['country'];
        });
      }
    } catch (error) {}
  }

  Future<void> fetchLatestItemdata() async {
    final QuerySnapshot itemDataSnapshot = await FirebaseFirestore.instance
        .collection('companies')
        .doc('items')
        .collection('item_data')
        .get();

    final List<ItemData> fetchedItems = itemDataSnapshot.docs.map((doc) {
      return ItemData.fromDocument(doc.id, doc);
    }).toList();

    setState(() {
      items = fetchedItems;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLatestItemdata();
    fetchCompanyData();
    filteredItems = items;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = items
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _deleteItem(String documentId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc('items')
          .collection('item_data')
          .doc(documentId)
          .delete();
      setState(() {
        items.removeWhere((item) => item.documentId == documentId);

        filteredItems = items;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: CustomText(
            text: 'Item deleted successfully.',
            color: Colors.white,
          ),
          backgroundColor: Colors.green,
        ),
      );
    } catch (error) {
      print('Error deleting item: $error');
    }
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                padding: const EdgeInsets.only(
                  left: 14,
                ),
                child: CustomText(
                  text: 'Recent Posts',
                  color: AppColors.black,
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 520,
                width: 330,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: searchController.text.isEmpty
                      ? items.length
                      : filteredItems.length,
                  itemBuilder: (context, index) {
                    final item = searchController.text.isEmpty
                        ? items[index]
                        : filteredItems[index];

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
                                      _deleteItem(item.documentId, context);
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
                          imagePath: item.imageUrl,
                          containerText: item.name,
                          locationText: companyName,
                          timeText: item.time,
                          onTap: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: ItemDetailsPage(
                                  itemId: item.itemId,
                                  image_Url: item.imageUrl,
                                  name: item.name,
                                  description: item.description,
                                  color: item.color,
                                  quantity: item.quantity,
                                  time: item.time,
                                  documentId: item.documentId,
                                  category: item.category,
                                  brand: item.brand,
                                  companyName: companyName,
                                  address: companyAddress,
                                  phoneNo: companyPhoneNo,
                                  date: item.date,
                                ),
                              ),
                            );
                          },
                          dateText: formatDateWithoutTime(item.date),
                        ),
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

class ItemData {
  final String documentId;
  final String itemId;
  final String name;
  final String category;
  final String brand;
  final String description;
  final String color;
  final int quantity;
  final DateTime date;
  final String time;
  final String imageUrl;

  ItemData({
    required this.documentId,
    required this.itemId,
    required this.name,
    required this.description,
    required this.color,
    required this.category,
    required this.brand,
    required this.quantity,
    required this.date,
    required this.time,
    required this.imageUrl,
  });

  factory ItemData.fromDocument(String documentId, DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    DateTime date = (data['date'] as Timestamp).toDate();
    return ItemData(
      documentId: documentId,
      itemId: data['itemId'],
      name: data['name'],
      description: data['description'],
      color: data['color'],
      quantity: data['quantity'],
      date: date,
      time: data['time'],
      imageUrl: data['image_url'],
      category: data['category'],
      brand: data['brand'],
    );
  }
}





















/*
 */