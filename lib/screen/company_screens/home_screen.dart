import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/provider/bottom_navigation_provider.dart';
import 'package:finder_app/screen/company_screens/company_screens.dart';
import 'package:finder_app/screen/company_screens/item_details_screen.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
          HomeScreen(),
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

  Future<void> fetchLatestItemdata() async {
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

  @override
  void initState() {
    super.initState();
    fetchLatestItemdata();
    fetchCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        backgroundColor: AppColors.green,
        location: companyAddress,
        name: companyName,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(5.0),
                child: CustomSearchField(hintText: 'Search items'),
              ),
              SizedBox(
                height: 10,
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
                height: 90,
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
              SizedBox(
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: ImageContainer(
                        imagePath: item.imageUrl,
                        containerText: item.name,
                        locationText: companyAddress,
                        timeText: item.time,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemDetailsPage(
                                  itemId: item.itemId,
                                  image_Url: item.imageUrl,
                                  name: item.name,
                                  description: item.description,
                                  color: item.color,
                                  quantity: item.quantity,
                                  //date: item.date,
                                  time: item.time),
                            ),
                          );
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

class ItemData {
  final String itemId;
  final String name;
  final String description;
  final String color;
  final int quantity;
  final DateTime date;
  final String time;
  final String imageUrl;

  ItemData({
    required this.itemId,
    required this.name,
    required this.description,
    required this.color,
    required this.quantity,
    required this.date,
    required this.time,
    required this.imageUrl,
  });

  factory ItemData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemData(
      itemId: data['itemId'],
      name: data['name'],
      description: data['description'],
      color: data['color'],
      quantity: data['quantity'],
      date: (data['date'] as Timestamp).toDate(),
      time: data['time'],
      imageUrl: data['image_url'],
    );
  }
}
