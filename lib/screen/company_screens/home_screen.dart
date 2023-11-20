import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/provider/bottom_navigation_provider.dart';
import 'package:finder_app/screen/company_screens/company_screens.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

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
          HomeScreen(),
          const AddItemScreen(),
          SettingsScreen(),
        ][index.selectedIndex],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ItemData> items = [];
  String companyName = '';
  String companyAddress = '';
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
                  color: Colors.black,
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
                                      color: Colors.red,
                                      text: 'Delete',
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.warning_amber,
                                      color: Colors.red,
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
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      _deleteItem(item.documentId, context);
                                      Navigator.of(context).pop();
                                    },
                                    child: CustomText(
                                      letterSpacing: 1,
                                      color: Colors.red,
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
                                ),
                              ),
                            );
                          },
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
    return ItemData(
      documentId: documentId,
      itemId: data['itemId'],
      name: data['name'],
      description: data['description'],
      color: data['color'],
      quantity: data['quantity'],
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'],
      imageUrl: data['image_url'],
      category: data['category'],
      brand: data['brand'],
    );
  }
}





















/*
 */