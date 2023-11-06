import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/screen/company_screens/home_screen.dart';
import 'package:finder_app/screen/register_screen.dart';
import 'package:flutter/material.dart';
import '../constant/app_colors.dart';
import '../widget/widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
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
        toolbarHeight: size.height * .3,
        backgroundColor: Colors.white,
        title: Image.asset(AppImages.logo),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: AppColors.darkGreen,
          tabs: const [
            Tab(
              text: 'Login as Guest',
            ),
            Tab(
              text: 'Login as Company',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: _tabController,
          children: const [
            LoginAsGuest(),
            LoginAsGuest(),
          ],
        ),
      ),
    );
  }
}

class LoginAsGuest extends StatefulWidget {
  const LoginAsGuest({super.key});

  @override
  State<LoginAsGuest> createState() => _LoginAsGuestState();
}

class _LoginAsGuestState extends State<LoginAsGuest> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              hinText: 'UserName',
              fillColor: Colors.white,
              controller: userNameController,
            ),
            CustomTextField(
              hinText: 'Password',
              fillColor: Colors.white,
              controller: passwordController,
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              btnColor: AppColors.darkGreen,
              textColor: Colors.white,
              text: 'Login',
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              width: size.width,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ));
                  },
                  child: CustomText(
                    text: 'Not a Member? Register',
                    size: 16,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
