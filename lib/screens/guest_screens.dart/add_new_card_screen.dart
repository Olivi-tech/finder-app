import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: AppColors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const CustomText(
          text: 'Card',
          letterSpacing: 1,
          color: AppColors.black,
          size: 18,
          weight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              CustomText(
                letterSpacing: 1,
                color: AppColors.black,
                size: 16,
                weight: FontWeight.w500,
                text: 'Name on Card*',
              ),
              CustomTextField(
                hintText: 'John Doe',
                keyboardType: TextInputType.name,
                obscureText: false,
                validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter Company Name';
                  } else if (!isValidName(input)) {
                    return 'Invalid Name';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                letterSpacing: 1,
                color: AppColors.black,
                size: 16,
                weight: FontWeight.w500,
                text: 'Card Number*',
              ),
              CustomTextField(
                  hintText: '1234 1234 1234 1234',
                  keyboardType: TextInputType.number,
                  obscureText: false,
                   validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter Company Name';
                  } else if (!isValidCreditCard(input)) {
                    return 'Invalid Name';
                  }
                  return null;
                },),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: CustomText(
                            letterSpacing: 1,
                            color: AppColors.black,
                            size: 16,
                            weight: FontWeight.w500,
                            text: 'Expiry*',
                          ),
                        ),
                        CustomTextField(
                            hintText: 'MM/YY',
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'Invalid';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 5),
                          child: CustomText(
                            letterSpacing: 1,
                            color: AppColors.black,
                            size: 16,
                            weight: FontWeight.w500,
                            text: 'CVV*',
                          ),
                        ),
                        CustomTextField(
                            hintText: '123',
                            keyboardType: TextInputType.number,
                            obscureText: false,
                            validator: (input) {
                              if (input == null || input.isEmpty) {
                                return 'Invalid';
                              }
                              return null;
                            }),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Image.asset(AppImages.addCard,
                              width: 40, height: 40),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: CustomText(
                  letterSpacing: 1,
                  color: AppColors.black,
                  size: 16,
                  weight: FontWeight.w500,
                  text: 'Zip Code',
                ),
              ),
              SizedBox(
                width: 150,
                child: CustomTextField(
                    hintText: '****',
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    validator: (input) {
                  if (input == null || input.isEmpty) {
                    return 'Please enter Company Name';
                  } else if (!isValidZipCode(input)) {
                    return 'Invalid Name';
                  }
                  return null;
                },),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                btnColor: AppColors.green,
                textColor: Colors.white,
                text: 'Save',
                onPressed: () async {},
                width: MediaQuery.sizeOf(context).width,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
