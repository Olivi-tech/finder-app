import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/db_servies.dart';
import 'package:finder_app/providers/providers.dart';
import 'package:finder_app/widgets/widgets.dart';
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
  TextEditingController nationalityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController idController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  FocusNode focusNode = FocusNode();
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nationalityController.dispose();
    phoneController.dispose();
    idController.dispose();
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
                    hintText: 'Name',
                    controller: nameController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Name';
                      } else if (!isValidName(input)) {
                        return 'Invalid Name';
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
                      nationalityController.text = country.name;
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
                    hintText: 'Nationality',
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter Country';
                      } else if (!isValidName(input)) {
                        return 'Invalid Nationality';
                      }
                      return null;
                    },
                    controller: nationalityController,
                  ),
                  CustomTextField(
                    obscureText: false,
                    hintText: 'ID/ Passport # ',
                    keyboardType: TextInputType.number,
                    controller: idController,
                    validator: (input) {
                      if (input == null || input.isEmpty) {
                        return 'Please enter ID/ Passport';
                      } else if (!isValidPhoneNumber(input)) {
                        return 'Invalid ID/ Passport';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  const SizedBox(height: 30),
                  CustomButton(
                    btnColor: AppColors.green,
                    textColor: Colors.white,
                    text: 'Register',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();
                        String roleMode = 'User';
                        try {
                          await DbService_auth.registerUser(
                            context,
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            phoneController.text,
                            nationalityController.text,
                            idController.text,
                            roleMode,
                          );
                        } catch (e) {
                          print('Registration failed: $e');
                        }
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
