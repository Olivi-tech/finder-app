import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/screens/guest_screens.dart/verify_screen.dart';
import 'package:finder_app/utils/app_utils.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GuestItemDetailsPage extends StatelessWidget {
  final data;

  const GuestItemDetailsPage({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
          text: 'Item Details',
          letterSpacing: 1,
          color: AppColors.black,
          size: 18,
          weight: FontWeight.w500,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: const CustomText(
                letterSpacing: 1,
                size: 18,
                weight: FontWeight.w600,
                color: AppColors.black,
                text: 'Picture',
              ),
            ),
            Container(
              width: 350,
              height: 250,
             child: CustomDisplayNetworkImage(imageUrl: data[AppText.image]),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomText(
                      letterSpacing: 1,
                      size: 18,
                      weight: FontWeight.w600,
                      color: AppColors.black,
                      text: 'Description',
                    ),
                    SizedBox(height: 20),
                    CustomRow(label: 'Category', value: data[AppText.category]),
                    CustomRow(label: 'Name', value: data[AppText.name]),
                    CustomRow(label: 'Brand', value: data[AppText.brand]),
                    CustomRow(label: 'Color', value: data[AppText.color]),
                    CustomRow(
                        label: 'Quantity',
                        value: data[AppText.quantity].toString()),
                    CustomRow(
                        label: 'Series',
                        value: data[AppText.series].toString()),
                    CustomRow(
                        label: 'Company Name',
                        value: data[AppText.companyName]),
                    CustomRow(
                        label: 'Company Category',
                        value: data[AppText.companyCategory]),
                    CustomRow(
                        label: 'Company Country',
                        value: data[AppText.companyCountry]),
                    CustomRow(
                        label: 'Company City',
                        value: data[AppText.companyCity]),
                    CustomRow(
                        label: 'Company Phone no',
                        value: data[AppText.companyPhoneNumber]),
                    const CustomText(
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                      color: AppColors.black,
                      text: 'Date & Time',
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          letterSpacing: 1,
                          size: 16,
                          weight: FontWeight.w300,
                          color: AppColors.black,
                          text: AppUtils.formatDateWithoutTime(
                              (data[AppText.date] as Timestamp).toDate()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: CustomText(
                              letterSpacing: 1,
                              size: 16,
                              weight: FontWeight.w600,
                              color: AppColors.black,
                              text: '|'),
                        ),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w300,
                            color: AppColors.black,
                            text: data[AppText.time]),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10),
                    const CustomText(
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                      color: AppColors.black,
                      text: 'Comments',
                    ),
                    SizedBox(height: 10),
                    CustomText(
                        letterSpacing: 1,
                        size: 16,
                        maxLine: 20,
                        weight: FontWeight.w300,
                        color: AppColors.black,
                        text: data[AppText.description]),
                  ]),
            ),
            const SizedBox(height: 30),
            CustomButton(
              btnColor: AppColors.green,
              textColor: Colors.white,
              text: 'Contact & Verify ',
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Image.asset(
                              AppImages.verified,
                              width: 40,
                              height: 40,
                              color: AppColors.green,
                            ),
                          ),
                          CustomText(
                            letterSpacing: 1,
                            weight: FontWeight.w600,
                            color: AppColors.black,
                            text: 'Are you sure?',
                          ),
                        ],
                      ),
                      content: CustomText(
                        letterSpacing: 1,
                        weight: FontWeight.w300,
                        color: AppColors.black,
                        text:
                            'Is it your lost items? If yes please go to chat box. If not then do another search.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: CustomText(
                            letterSpacing: 1,
                            text: 'Cancel',
                            color: AppColors.black,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    child: VerifyScreen()));
                          },
                          child: CustomText(
                            letterSpacing: 1,
                            color: AppColors.blue,
                            text: 'Message',
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              width: size.width,
            ),
            const SizedBox(
              height: 100,
            ),
          ]),
        ),
      ),
    );
  }
}
