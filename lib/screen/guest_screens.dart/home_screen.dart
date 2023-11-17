import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/model/item_model.dart';
import 'package:finder_app/screen/guest_screens.dart/guest_screens.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => GuestHomeScreenState();
}

class GuestHomeScreenState extends State<GuestHomeScreen> {
  List<ItemData> items = [];
  String name = '';
  String companyName = '';

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

  Future<void> fetchCompanyData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('companies')
          .doc(uid)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          companyName = userSnapshot['name'];
        });
      }
    } catch (error) {}
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

  @override
  void initState() {
    super.initState();
    fetchItemData();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Padding(
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
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Recent Posts $companyName',
                      color: Colors.black,
                      letterSpacing: 1,
                      size: 20,
                      weight: FontWeight.w500,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text:
                          'We would like to inform you about some lost items that have been found. You can check them out here',
                      color: Colors.black,
                      size: 16,
                      weight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 600,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PostContainer(
                        imagePath: item.imageUrl,
                        containerText: item.name,
                        timeText: item.time,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GuestItemDetailsPage(
                                itemId: item.itemId,
                                image_Url: item.imageUrl,
                                name: item.name,
                                description: item.description,
                                color: item.color,
                                quantity: item.quantity,
                                //date: item.date,
                                time: item.time,
                              ),
                            ),
                          );
                        },
                        describtionText: item.description,
                        ontapcontact: () {
                          Navigator.pushNamed(context, AppRoutes.guestContact);
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
