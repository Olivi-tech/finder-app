import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
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
  late CollectionReference collection;
  String? uid = FirebaseAuth.instance.currentUser?.uid;

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
            child: StreamBuilder(
              stream: collection.doc(uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
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
                            image: NetworkImage(snapshot.data![AppText.image]),
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
                        value: snapshot.data![AppText.name],
                      ),
                      Divider(color: Colors.grey),
                      CustomUserInfoRow(
                          label: 'Phone no',
                          value: snapshot.data![AppText.phoneNumber]),
                      Divider(color: Colors.grey),
                      CustomUserInfoRow(
                          label: 'Email', value: snapshot.data![AppText.email]),
                      Divider(color: Colors.grey),
                      CustomUserInfoRow(
                          label: 'Nationality',
                          value: snapshot.data![AppText.country]),
                      Divider(color: Colors.grey),
                      CustomUserInfoRow(
                          label: 'ID/ Passport # ',
                          value: snapshot.data![AppText.address]),
                      SizedBox(
                        height: 40,
                      ),
                    ],
                  );
                } else {
                  return const CupertinoActivityIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
