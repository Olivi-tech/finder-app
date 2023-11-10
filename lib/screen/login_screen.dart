import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/screen/company_screens/login_screen.dart';
import 'package:finder_app/utils/app_routs.dart';
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
        toolbarHeight: size.height * .2,
        backgroundColor: Colors.white,
        title: Image.asset(AppImages.logo),
        centerTitle: true,
         elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          indicatorColor: AppColors.green,
          labelStyle: TextStyle(
            letterSpacing: 0.50,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          tabs: const [
            Tab(
              text: 'Login as Company',
            ),
            Tab(
              text: 'Login as Guest',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TabBarView(
          controller: _tabController,
          children: const [
            LoginAsCompany(),
            LoginAsGest(),
          ],
        ),
      ),
    );
  }
}

class LoginAsGest extends StatefulWidget {
  const LoginAsGest({super.key});

  @override
  State<LoginAsGest> createState() => _LoginAsGestState();
}

class _LoginAsGestState extends State<LoginAsGest> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(
                hintText: 'Email',
                fillColor: Colors.white,
                controller: emailController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter an email address';
                  } else if (!isValidEmail(input)) {
                    return 'Invalid email address';
                  }
                  return null;
                },
              ),
              CustomTextField(
                hintText: 'Password',
                fillColor: Colors.white,
                controller: passwordController,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter a password';
                  } else if (input.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomButton(
                btnColor: AppColors.green,
                textColor: Colors.white,
                text: 'Login',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    try {
                      await DbService_auth.loginUser(
                        context,
                        emailController.text,
                        passwordController.text,
                      );
                    } catch (e) {
                      print('Login failed: $e');
                    }
                  }
                },
                width: size.width,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.guestRegister);
                    },
                    child: CustomText(
                      text: 'Not a Member? Register',
                      letterSpacing: 0.50,
                      size: 16,
                      weight: FontWeight.w300,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
