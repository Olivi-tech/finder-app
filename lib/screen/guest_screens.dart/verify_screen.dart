import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/widget/custom_profile_details_row.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => VerifyScreenState();
}

class VerifyScreenState extends State<VerifyScreen> {
  String companyName = '';
  String companyAddress = '';
  String companPhoneNo = '';
  String companyCountry = '';

  Future<void> fetchUserData() async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot companySnapshot = await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .get();

      if (companySnapshot.exists) {
        setState(() {
          companyName = companySnapshot['name'];
          companyAddress = companySnapshot['address'];
          companPhoneNo = companySnapshot['phoneNo'];
          companyCountry = companySnapshot['country'];
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
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const CustomText(
            text: 'Send Details',
            letterSpacing: 1,
            color: Colors.black,
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
                        color: Colors.blue,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomUserInfoRow(
                  label: 'Name',
                  value: companyName,
                ),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Phone no', value: companPhoneNo),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Country', value: companyCountry),
                Divider(color: Colors.grey),
                CustomUserInfoRow(
                    label: 'ID/ Passport # ', value: companyAddress),
                SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Select Payment Method',
                  letterSpacing: 1,
                  color: Colors.black,
                  size: 18,
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  height: 80,
                ),
                CustomButton(
                  btnColor: AppColors.green,
                  textColor: Colors.white,
                  text: 'Send',
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
