import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/providers/providers.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:provider/provider.dart';

class RegisterCompanyScreen extends StatefulWidget {
  const RegisterCompanyScreen({super.key});

  @override
  State<RegisterCompanyScreen> createState() => _RegisterCompanyScreenState();
}

class _RegisterCompanyScreenState extends State<RegisterCompanyScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryController =
      TextEditingController(text: 'Saudi Arabia');
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController crNoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    emailController.dispose();
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
                  CustomText(
                    text: AppText.registerText,
                    size: 14,
                    weight: FontWeight.w300,
                    letterSpacing: 0.50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'Company Name',
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Company Name';
                      } else if (!isValidName(input)) {
                        return 'Invalid Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    hintText: 'Category',
                    readOnly: true,
                    obscureText: false,
                    controller: categoryController,
                    suffixIcon: DropDownsWidget(
                      itemList: ['Mall', 'Park'],
                      controller: categoryController,
                      onChanged: (String? selectedOption) {
                        categoryController.text = selectedOption ?? '';
                      },
                    ),
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Category';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'Company Registration Number',
                    controller: crNoController,
                    keyboardType: TextInputType.number,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter CR Number';
                      } else if (!isValidCRNumber(input)) {
                        return 'Invalid Name';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
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
                    controller: phoneNoController,
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
                    initialCountryCode: 'SA',
                    languageCode: "en",
                    onChanged: (phone) {
                      print(phone.completeNumber);
                    },
                    onCountryChanged: (country) {
                      countryController.text = country.name;
                    },
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
                    readOnly: true,
                    hintText: 'Country',
                    controller: countryController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Enter country';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'City',
                    controller: cityController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter City';
                      } else if (!isValidName(input)) {
                        return 'Invalid city';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'Address',
                    maxLines: 4,
                    controller: addressController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Company Address';
                      } else if (!isValidAddress(input)) {
                        return 'Invalid address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    btnColor: AppColors.green,
                    textColor: Colors.white,
                    text: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState!.validate() &&
                          phoneNoController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        String roleMode = 'Company';
                        try {
                          await DbService_auth.registerCompany(
                            context,
                            nameController.text,
                            categoryController.text,
                            crNoController.text,
                            emailController.text,
                            passwordController.text,
                            phoneNoController.text,
                            countryController.text,
                            cityController.text,
                            addressController.text,
                            roleMode,
                          );
                        } catch (e) {
                          print('Registration failed: $e');
                        }
                      } else {
                        CustomSnackBar.show(
                          context: context,
                          text: 'Please fill all fields.',
                          backgroundColor: AppColors.red,
                        );
                      }
                    },
                    width: MediaQuery.sizeOf(context).width,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
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
                              color: AppColors.blue,
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
