import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/app_colors.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/custom_profile_details_row.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Future<void> fetchUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot dataSnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .get();

      if (dataSnapshot.exists) {
        setState(() {
          name = dataSnapshot['name'];
          address = dataSnapshot['address'];
          phoneNo = dataSnapshot['phoneNo'];
          country = dataSnapshot['country'];
          email = dataSnapshot['email'];
          nationality = dataSnapshot['nationality'];
        });
      }
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  bool isLoggingOut = false;
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
          title: const CustomText(
            text: 'Profile',
            letterSpacing: 1,
            color: AppColors.black,
            size: 18,
            weight: FontWeight.w500,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 152,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.lightwhite),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image,
                        size: 48,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const CustomText(
                        text: 'Copy upload/KYC',
                        letterSpacing: 1,
                        size: 12,
                        color: AppColors.blue,
                        weight: FontWeight.w600,
                      ),
                    ],
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
                CustomButton(
                  btnColor: AppColors.green,
                  textColor: Colors.white,
                  text: 'See Subscription Plan',
                  onPressed: () async {
                    Navigator.of(context).pushNamed(AppRoutes.subscriptions);
                  },
                  width: MediaQuery.sizeOf(context).width,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  btnColor: AppColors.green,
                  textColor: Colors.white,
                  text: 'Save',
                  onPressed: () async {},
                  width: MediaQuery.sizeOf(context).width,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
