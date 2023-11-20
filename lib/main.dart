import 'package:finder_app/firebase_options.dart';
import 'package:finder_app/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finder_app/provider/provider.dart';
import 'package:finder_app/routs.dart';
import 'package:finder_app/screen/company_screens/home_screen.dart';
import 'package:finder_app/screen/guest_screens.dart/home_screen.dart';
import 'package:finder_app/screen/screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   Widget initialScreen = SplashScreen();

  @override
  void initState() {
    super.initState();
    initializeApp();
  }

  Future<void> initializeApp() async {
    await clearSharedPreferences();

    bool isLoggedIn = await checkIfUserLoggedIn();
    bool isCompanyUser = await determineUserType();

    setState(() {
      initialScreen = isLoggedIn
          ? (isCompanyUser ? GuestHomeScreen() : HomePage())
          : LoginScreen ();
    });
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<bool> checkIfUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  Future<bool> determineUserType() async {
    String userType = await getUserTypeFromSomeStorage();
    return userType == 'company';
  }

  Future<String> getUserTypeFromSomeStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userType') ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BottomNavigationProvider>(
          create: (context) {
            return BottomNavigationProvider();
          },
        ),
        ChangeNotifierProvider<PasswordIconToggleProvider>(
          create: (context) {
            return PasswordIconToggleProvider();
          },
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
        home: initialScreen,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}

class ScrollBehaviorController extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
