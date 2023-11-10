import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/widget/custom_button.dart';
import 'package:finder_app/widget/custom_dropdown.dart';
import 'package:finder_app/widget/custom_text.dart';
import 'package:finder_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';

class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
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
    cityController.dispose();
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
                      text: 'Register your Company',
                      size: 18,
                      letterSpacing: 0.50,
                      weight: FontWeight.w400,
                    ),
                  ),
                  CustomTextField(
                    hintText: 'Company Name',
                    fillColor: Colors.white,
                    controller: nameController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Company Name';
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
                    return 'Please enter a password';
                  } else if (input.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
              ),
                  CustomTextField(
                    hintText: 'Phone No',
                    fillColor: Colors.white,
                    controller: phoneNoController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Phone no';
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
                    hintText: 'City',
                    fillColor: Colors.white,
                    controller: cityController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter city';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Address',
                    fillColor: Colors.white,
                    controller: addressController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Company Address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 50),
                  CustomButton(
                    btnColor: AppColors.green,
                    textColor: Colors.white,
                    text: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        try {
                          await DbService_auth.registerCompany(
                            context,
                            nameController.text,
                            userNameController.text,
                            passwordController.text,
                            countryController.text,
                            cityController.text,
                            addressController.text,
                            phoneNoController.text,
                          );
                        } catch (e) {
                          print('Registration failed: $e');
                        }
                      }
                    },
                    width: MediaQuery.sizeOf(context).width,
                  ),
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