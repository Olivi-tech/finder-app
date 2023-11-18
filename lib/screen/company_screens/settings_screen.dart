import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/custom_profile_details_row.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late File? _image;
  final picker = ImagePicker();

  String companyName = '';
  String companyAddress = '';
  String companPhoneNo = '';
  String companyCountry = '';

  Future getImageGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No Image  picked !');
      }
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
          companPhoneNo = companySnapshot['phoneNo'];
          companyCountry = companySnapshot['country'];
        });
      }
    } catch (error) {}
  }

  @override
  void initState() {
    super.initState();
    _image = null;
    fetchCompanyData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0.0,
          title: const CustomText(
            text: ' Settings',
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
              children: [
                GestureDetector(
                  onTap: () async {
                    getImageGallery();
                  },
                  child: Center(
                    child: Container(
                      height: 152,
                      width: 152,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lightwhite),
                      child: _image != null
                          ? Image.file(
                              _image!.absolute,
                              height: 152,
                              width: 152,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 152,
                                  width: 152,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(10.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(AppImages.companylogo),
                                    ),
                                  ),
                                ),
                                /*  Icon(
                                  Icons.person,
                                  size: 48,
                                  color: AppColors.green,
                                ),
                                const SizedBox(
                                  height: 5,)*/
                              ],
                            ),
                    ),
                  ),
                ),
                /* Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Edit',
                      letterSpacing: 1,
                      size: 12,
                      color: Colors.blue,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.edit,
                      size: 14,
                      color: Colors.blue,
                    ),
                  ],
                ),*/
                SizedBox(
                  height: 40,
                ),
                CustomUserInfoRow(
                  label: 'Company Name',
                  value: companyName,
                ),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Phone no', value: companPhoneNo),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Country', value: companyCountry),
                Divider(color: Colors.grey),
                CustomUserInfoRow(label: 'Address', value: companyAddress),
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: CustomButton(
                    btnColor: AppColors.green,
                    textColor: Colors.white,
                    text: 'Logout',
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signOut();
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                            'logout Sucessfully',
                            style: TextStyle(color: Colors.white),
                          ),
                          duration: Duration(seconds: 2),
                        );
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.login);
                      } catch (e) {
                        print("Error during logout: $e");
                      }
                    },
                    width: MediaQuery.sizeOf(context).width,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
