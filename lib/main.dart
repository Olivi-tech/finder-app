import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/firebase_options.dart';
import 'package:finder_app/providers/item_filter_provider.dart';
import 'package:finder_app/screens/company_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finder_app/providers/providers.dart';
import 'package:finder_app/routs.dart';
import 'package:finder_app/screens/screens.dart';
import 'constants/constants.dart';
import 'screens/guest_screens.dart/guest_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (context) => BottomNavigationProvider(),
        ),
        ChangeNotifierProvider<PasswordIconToggleProvider>(
          create: (context) => PasswordIconToggleProvider(),
        ),
        ChangeNotifierProvider<ImagePickerProvider>(
          create: (context) => ImagePickerProvider(),
        ),
        ChangeNotifierProvider<CheckListFilterProvider>(
          create: (context) => CheckListFilterProvider(),
        ),
        ChangeNotifierProvider<ItemFilterProvider>(
          create: (context) => ItemFilterProvider(),
        ),
      ],
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: ScrollBehaviorController(),
            child: child!,
          );
        },
        debugShowCheckedModeBanner: false,
        home: AuthenticationWrapper(),
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection(AppText.userDataCollection)
            .doc(user.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data?.exists == true) {
              final roleMode = snapshot.data?.get(AppText.roleModel) ?? '';
              if (roleMode == 'User') {
                return GuestHomeScreen();
              } else {
                return CompanyHomeScreen();
              }
            }
          }
          return SplashScreen();
        },
      );
    } else {
      log('splash screen ===   call ///////');
      return SplashScreen();
    }
  }
}

class ScrollBehaviorController extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
