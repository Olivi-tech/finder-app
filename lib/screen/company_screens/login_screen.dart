import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/provider/provider.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginAsCompany extends StatefulWidget {
  const LoginAsCompany({super.key});

  @override
  State<LoginAsCompany> createState() => _LoginAsCompanyState();
}

class _LoginAsCompanyState extends State<LoginAsCompany> {
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
                      await DbService_auth.loginCompany(
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
                    Navigator.pushReplacementNamed(context, AppRoutes.register);
                   
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
                        color: Colors.blue,
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
    );
  }
}
