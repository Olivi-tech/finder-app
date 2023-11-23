import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/firebase_options.dart';
import 'package:finder_app/screens/company_screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finder_app/providers/providers.dart';
import 'package:finder_app/routs.dart';
import 'package:finder_app/screens/screens.dart';

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
            .collection('userData')
            .doc(user.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data?.exists == true) {
              final roleMode = snapshot.data?.get('roleMode') ?? '';

              if (roleMode == 'User') {
                return GuestHomeScreen();
              }
            } else {
              return CompanyHomeScreen();
            }
          }

          return SplashScreen();
        },
      );
    } else {
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
