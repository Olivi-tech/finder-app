import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/app_colors.dart';
import 'package:finder_app/constants/app_images.dart';
import 'package:finder_app/screens/company_screens/company_screens.dart';
import 'package:finder_app/widgets/custom_profile_details_row.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String companyName = '';
  String companyAddress = '';
  String companPhoneNo = '';
  String companyCountry = '';
  String companyCrNumber = '';
  @override
  void initState() {
    super.initState();
    fetchCompanyData();
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
          companPhoneNo = companySnapshot['phoneNo'];
          companyCountry = companySnapshot['country'];
          companyCrNumber = companySnapshot['crNumber'];
        });
      }
    } catch (error) {}
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
            title: const CustomText(
              text: ' Settings',
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
                children: [
                  Center(
                    child: Container(
                        height: 152,
                        width: 152,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(AppImages.companylogo),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  CustomUserInfoRow(
                    label: 'Company Name',
                    value: companyName,
                  ),
                  Divider(color: Colors.grey),
                  CustomUserInfoRow(label: 'CR Number', value: companyCrNumber),
                  Divider(color: Colors.grey),
                  CustomUserInfoRow(
                      label: 'Phone Number', value: companPhoneNo),
                  Divider(color: Colors.grey),
                  CustomUserInfoRow(label: 'Country', value: companyCountry),
                  Divider(color: Colors.grey),
                  CustomUserInfoRow(label: 'Address', value: companyAddress),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          setState(() {
                            isLoggingOut = true;
                          });
                          await FirebaseAuth.instance.signOut();
                          SnackBar(
                            backgroundColor: AppColors.red,
                            content: Text(
                              'logout Sucessfully',
                              style: TextStyle(color: Colors.white),
                            ),
                            duration: Duration(seconds: 2),
                          );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (Route<dynamic> route) => false,
                          );
                        } catch (e) {
                          print("Error during logout: $e");
                        } finally {
                          setState(() {
                            isLoggingOut = false;
                          });
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 142,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.green,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            isLoggingOut
                                ? CupertinoActivityIndicator(
                                    color: AppColors.red,
                                  )
                                : Icon(
                                    Icons.logout,
                                    size: 16,
                                    color: AppColors.red,
                                  ),
                            CustomText(
                              text: 'Logout',
                              size: 16,
                              weight: FontWeight.w500,
                              letterSpacing: 0.50,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
