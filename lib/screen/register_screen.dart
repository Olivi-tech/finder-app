import 'package:finder_app/constant/app_images.dart';
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
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 100, child: Image.asset(AppImages.logo)),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CustomText(
                    text: 'Register your Company',
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                CustomTextField(
                  hinText: 'Name',
                  fillColor: Colors.white,
                  controller: nameController,
                ),
                DropDownWidget(
                    itemList: const ['Category'],
                    controller: categoryController,
                    onChanged: (value) {}),
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
                DropDownWidget(
                    itemList: const ['Country'],
                    controller: countryController,
                    onChanged: (value) {}),
                CustomTextField(
                  hinText: 'City',
                  fillColor: Colors.white,
                  controller: cityController,
                ),
                CustomTextField(
                  hinText: 'Address',
                  fillColor: Colors.white,
                  controller: addressController,
                ),
                CustomButton(
                  text: 'Register',
                  onPressed: () {},
                  width: MediaQuery.sizeOf(context).width,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
