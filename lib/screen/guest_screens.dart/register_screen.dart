import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/custom_button.dart';
import 'package:finder_app/widget/custom_dropdown.dart';
import 'package:finder_app/widget/custom_text.dart';
import 'package:finder_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> countries = [
    'Pakistan',
    'United States',
    'India',
    'Canada',
    'Australia',
    'United Kingdom',
    'Germany',
    'France',
  ];
  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    countryController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 100, child: Image.asset(AppImages.logo)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomText(
                      text: 'Register yourself',
                      size: 18,
                      letterSpacing: 0.50,
                      weight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Name',
                    fillColor: Colors.white,
                    controller: nameController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Email',
                    fillColor: Colors.white,
                    controller: userNameController,
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
                        return 'Please enter Password';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Phone',
                    fillColor: Colors.white,
                    controller: phoneController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter phone';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Country',
                    readOnly: true,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Country';
                      }
                      return null;
                    },
                    fillColor: Colors.white,
                    controller: countryController,
                    suffixIcon: DropDownsWidget(
                      itemList: countries,
                      controller: countryController,
                      onChanged: (String? selectedOption) {
                        countryController.text = selectedOption ?? '';
                      },
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Address',
                    fillColor: Colors.white,
                    controller: addressController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    btnColor: AppColors.green,
                    textColor: Colors.white,
                    text: 'Register',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        Navigator.pushNamed(context, AppRoutes.guesthome);
                      }
                    },
                    width: MediaQuery.sizeOf(context).width,
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





























/** CustomTextField(
                    hintText: 'Category',
                    readOnly: true,
                    fillColor: Colors.white,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Company Category';
                      }
                      return null;
                    },
                    controller: categoryController,
                    suffixIcon: DropDownsWidget(
                      itemList: List<String>.generate(
                          5, (index) => (index + 1).toString()),
                      controller: categoryController,
                      onChanged: (String? selectedOption) {
                        categoryController.text = selectedOption ?? '';
                      },
                    ),
                  ), */