import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/app_colors.dart';
import 'package:finder_app/widgets/custom_profile_details_row.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String name = '';
  String address = '';
  String phoneNo = '';
  String country = '';
  String nationality = '';
  String email = '';
  String image = '';
  Future<void> fetchUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .get();

      if (companySnapshot.exists) {
        setState(() {
          name = companySnapshot['name'];
          address = companySnapshot['address'];
          phoneNo = companySnapshot['phoneNo'];
          email = companySnapshot['email'];
          country = companySnapshot['country'];
          image = companySnapshot['image'];
        });
      }
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: AppColors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  text: 'Profile Details',
                  letterSpacing: 1,
                  color: AppColors.black,
                  size: 20,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 152,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomUserInfoRow(
                  label: 'Company Name',
                  value: name,
                ),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Phone no', value: phoneNo),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Email', value: email),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Nationality', value: country),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'ID/ Passport # ', value: address),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
