import 'package:finder_app/constant/app_colors.dart';
import 'package:finder_app/constant/app_images.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/provider/provider.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widget/custom_button.dart';
import 'package:finder_app/widget/custom_text.dart';
import 'package:finder_app/widget/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class RegisterAsGuestScreen extends StatefulWidget {
  const RegisterAsGuestScreen({super.key});

  @override
  State<RegisterAsGuestScreen> createState() => _RegisterAsGuestScreenState();
}

class _RegisterAsGuestScreenState extends State<RegisterAsGuestScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
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
                    obscureText: false,
                    hintText: 'Name',
                    controller: nameController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'Email',
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
                    height: 10,
                  ),
                  IntlPhoneField(
                    disableLengthCheck: false,
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    focusNode: focusNode,
                    decoration: InputDecoration(
                      fillColor: Colors.transparent,
                      hintText: 'Phone No',
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 0.7,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0.7, color: AppColors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    languageCode: "en",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      countryController.text = country.name;
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    validator: (PhoneNumber? input) {
                      if (input == null || input.number.isEmpty) {
                        return 'Please enter a phone number';
                      } else if (!isValidPhoneNumber(input.completeNumber)) {
                        return 'Invalid phone number';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'Country',
                    readOnly: true,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Country';
                      }
                      return null;
                    },
                    controller: countryController,
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'Address',
                    controller: addressController,
                    maxLines: 4,
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
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        try {
                          await DbService_auth.registerUser(
                            context,
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            phoneController.text,
                            countryController.text,
                            addressController.text,
                          );
                        } catch (e) {
                          print('Registration failed: $e');
                        }
                      }
                    },
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.login);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: 'Already member?',
                              letterSpacing: 0.50,
                              size: 16,
                              weight: FontWeight.w300,
                            ),
                            CustomText(
                              text: ' Sign in',
                              letterSpacing: 0.50,
                              size: 16,
                              color: Colors.blue,
                              weight: FontWeight.w600,
                            ),
                          ],
                        )),
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

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(r'^\+?[0-9]+$');
  return regex.hasMatch(phoneNumber);
}



























/** CustomTextField(
                    hintText: 'Category',
                    readOnly: true,
                  
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