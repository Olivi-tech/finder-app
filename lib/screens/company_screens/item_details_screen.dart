import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemDetailsPage extends StatelessWidget {
  final data;

  ItemDetailsPage({required this.data});

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
          letterSpacing: 1,
          size: 18,
          weight: FontWeight.w500,
          color: AppColors.black,
          text: 'Item Details',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: const CustomText(
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                  color: AppColors.black,
                  text: 'Picture',
                ),
              ),
              Container(
                width: 350,
                height: 250,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(data[AppText.image]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        letterSpacing: 1,
                        size: 16,
                        weight: FontWeight.w600,
                        color: AppColors.black,
                        text: 'Description',
                      ),
                      SizedBox(height: 20),
                      CustomRow(
                          label: 'Category', value: data[AppText.category]),
                      CustomRow(label: 'Name', value: data[AppText.name]),
                      CustomRow(label: 'Brand', value: data[AppText.brand]),
                      CustomRow(label: 'Color', value: data[AppText.color]),
                      CustomRow(
                          label: 'Quantity',
                          value: data[AppText.quantity].toString()),
                      CustomRow(
                          label: 'Company Name',
                          value: data[AppText.companyName]),
                      CustomRow(label: 'Address', value: data[AppText.companyAddress]),
                      CustomRow(
                          label: 'Phone no', value: data[AppText.companyPhoneNumber]),
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
                              text: formatDateWithoutTime(
                                  (data[AppText.date] as Timestamp).toDate())),
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
                        text: 'Comments',
                      ),
                      SizedBox(height: 10),
                      CustomText(
                          letterSpacing: 1,
                          size: 16,
                          maxLine: 20,
                          weight: FontWeight.w300,
                          color: AppColors.black,
                          text: AppText.description),
                      SizedBox(height: 150),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String formatDateWithoutTime(DateTime dateTime) {
  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(dateTime);
}
