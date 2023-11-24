import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/screens/screens.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GuestSettingScreen extends StatefulWidget {
  const GuestSettingScreen({super.key});

  @override
  State<GuestSettingScreen> createState() => _GuestSettingScreenState();
}

class _GuestSettingScreenState extends State<GuestSettingScreen> {
  bool isLoggingOut = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: CustomText(
              text: 'Settings',
              letterSpacing: 1,
              color: AppColors.black,
              size: 28,
              weight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 50),
          ListTile(
            leading: Icon(
              Icons.person,
              color: AppColors.green,
            ),
            title: CustomText(
              text: 'Profile',
              letterSpacing: 1,
              color: AppColors.black,
              size: 18,
              weight: FontWeight.w300,
            ),
            trailing: Icon(
              size: 16,
              Icons.arrow_forward_ios,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.guestProfile);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.credit_card,
              color: AppColors.green,
            ),
            title: CustomText(
              text: 'Subscription',
              letterSpacing: 1,
              color: AppColors.black,
              size: 18,
              weight: FontWeight.w300,
            ),
            trailing: Icon(
              size: 16,
              Icons.arrow_forward_ios,
              color: AppColors.black,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.subscriptions);
            },
          ),
          ListTile(
            leading: isLoggingOut
                ? CupertinoActivityIndicator(
                    color: AppColors.red,
                  )
                : Icon(
                    Icons.logout,
                    color: AppColors.red,
                  ),
            title: CustomText(
              text: 'Logout',
              letterSpacing: 1,
              color: AppColors.black,
              size: 18,
              weight: FontWeight.w300,
            ),
            onTap: () async {
              try {
                setState(() {
                  isLoggingOut = true;
                });

                await FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
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
          ),
          SizedBox(height: 20),
        ]),
      ),
    );
  }
}
