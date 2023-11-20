import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/screen/company_screens/company_screens.dart';
import 'package:finder_app/screen/guest_screens.dart/guest_screens.dart';
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with TickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * .1,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.asset(
            AppImages.logo,
            height: 80,
            width: 150,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelStyle: TextStyle(
            letterSpacing: 0.50,
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          indicatorColor: AppColors.green,
          labelStyle: TextStyle(
            letterSpacing: 0.50,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
          tabs: const [
            Tab(
              text: 'Register as Company',
            ),
            Tab(
              text: 'Register as Guest',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: _tabController,
          children: const [RegisterCompanyScreen(), RegisterAsGuestScreen()],
        ),
      ),
    );
  }
}
