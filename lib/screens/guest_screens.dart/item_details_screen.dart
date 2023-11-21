import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/screens/guest_screens.dart/verify_screen.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class GuestItemDetailsPage extends StatelessWidget {
  final String itemId;
  final String image_Url;
  final String name;
  final String description;
  final String color;
  final int quantity;
  final String category;

  final String brand;
  // final String date;
  final String time;
  final String companyName;
  final String address;
  const GuestItemDetailsPage({
    Key? key,
    required this.itemId,
    required this.image_Url,
    required this.name,
    required this.description,
    required this.color,
    required this.quantity,
    required this.time,
    required this.companyName,
    required this.address,
    required this.category,
    required this.brand,
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
                weight: FontWeight.w500,
                color: AppColors.black,
                text: 'Picture',
              ),
            ),
            Container(
              width: 350,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(image_Url),
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
                      size: 18,
                      weight: FontWeight.w500,
                      color: AppColors.black,
                      text: 'Description',
                    ),
                    SizedBox(height: 20),
                    CustomRow(label: 'Category', value: category),
                    CustomRow(label: 'Name', value: name),
                    CustomRow(label: 'Brand', value: brand),
                    CustomRow(label: 'Color', value: color),
                    CustomRow(label: 'Quantity', value: quantity.toString()),
                    CustomRow(label: 'Company Name', value: companyName),
                    CustomRow(label: 'Address', value: address),
                    const CustomText(
                      letterSpacing: 1,
                      size: 18,
                      weight: FontWeight.w500,
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
                            weight: FontWeight.w400,
                            color: AppColors.black,
                            text: time),
                      ],
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10),
                    const CustomText(
                      letterSpacing: 1,
                      size: 18,
                      weight: FontWeight.w500,
                      color: AppColors.black,
                      text: 'Comments',
                    ),
                    SizedBox(height: 10),
                    CustomText(
                        letterSpacing: 1,
                        size: 16,
                        maxLine: 20,
                        weight: FontWeight.w400,
                        color: AppColors.black,
                        text: description),
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
                      title: CustomText(
                        letterSpacing: 1,
                        weight: FontWeight.w600,
                        color: AppColors.black,
                        text: 'Verify',
                      ),
                      content: const Text(
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
