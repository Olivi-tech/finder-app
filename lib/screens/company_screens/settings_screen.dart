import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/widgets/custom_profile_details_row.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import '../screens.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? uid = FirebaseAuth.instance.currentUser?.uid;

  late CollectionReference collection;

  @override
  void initState() {
    super.initState();

    collection =
        FirebaseFirestore.instance.collection(AppText.userDataCollection);
  }

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
              child: StreamBuilder(
                stream: collection.doc(uid!).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
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
                          value: snapshot.data![AppText.name],
                        ),
                        Divider(color: Colors.grey),
                        CustomUserInfoRow(
                          label: 'CR Number',
                          value: snapshot.data![AppText.crNumber],
                        ),
                        Divider(color: Colors.grey),
                        CustomUserInfoRow(
                          label: 'Phone Number',
                          value: snapshot.data![AppText.phoneNumber],
                        ),
                        Divider(color: Colors.grey),
                        CustomUserInfoRow(
                          label: 'Country',
                          value: snapshot.data![AppText.country],
                        ),
                        Divider(color: Colors.grey),
                        CustomUserInfoRow(
                          label: 'Address',
                          value: snapshot.data![AppText.address],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              SnackBar(
                                backgroundColor: AppColors.red,
                                content: Text(
                                  'logout Successfully',
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
                            },
                            child: Container(
                              height: 40,
                              width: 142,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.green,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
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
                    );
                  } else {
                    return CupertinoActivityIndicator();
                  }
                },
              ),
            ),
          )),
    );
  }
}
