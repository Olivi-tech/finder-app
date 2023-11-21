import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/providers/providers.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset(
                    AppImages.logo,
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        AppImages.waveHey,
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CustomText(
                        text: 'Hey,',
                        size: 16,
                        weight: FontWeight.w600,
                        letterSpacing: 0.50,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: AppText.welcomeText,
                    size: 16,
                    weight: FontWeight.w300,
                    letterSpacing: 0.50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: 'Login',
                    size: 18,
                    color: AppColors.blue,
                    weight: FontWeight.w600,
                    letterSpacing: 0.50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    obscureText: false,
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
                  Consumer<PasswordIconToggleProvider>(
                    builder: (context, value, child) => CustomTextField(
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Please enter a password';
                        } else if (input.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: value.isVisible ? false : true,
                      controller: passwordController,
                      hintText: 'Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          Provider.of<PasswordIconToggleProvider>(context,
                                  listen: false)
                              .setIsVisible = !value.isVisible;
                        },
                        child: Icon(
                          value.isVisible
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.grey,
                        ),
                      ),
                    ),
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
                          await DbService_auth.login(
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
                        Navigator.pushNamed(context, AppRoutes.register);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'Donot have account?',
                            letterSpacing: 0.50,
                            size: 16,
                            weight: FontWeight.w300,
                          ),
                          CustomText(
                            text: ' Register Now',
                            letterSpacing: 0.50,
                            size: 16,
                            color: AppColors.blue,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
