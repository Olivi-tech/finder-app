import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/screen/guest_screens.dart/verify_screen.dart';
import 'package:finder_app/widget/widget.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const CustomText(
          text: 'Item Details',
          letterSpacing: 1,
          color: Colors.black,
          size: 16,
          weight: FontWeight.w600,
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
                size: 20,
                weight: FontWeight.w500,
                color: Colors.black,
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
                      size: 20,
                      weight: FontWeight.w500,
                      color: Colors.black,
                      text: 'Description',
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Company Name',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: companyName),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Address',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: address),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Category',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: category),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Name',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: name),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Brand',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: brand),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Color',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: color),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(
                          letterSpacing: 1,
                          size: 18,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          text: 'Quantity',
                        ),
                        SizedBox(height: 10),
                        CustomText(
                            letterSpacing: 1,
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black,
                            text: quantity.toString()),
                      ],
                    ),
                    SizedBox(height: 10),
                    const CustomText(
                      letterSpacing: 1,
                      size: 18,
                      weight: FontWeight.w600,
                      color: Colors.black,
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
                            color: Colors.black,
                            text: time),
                      ],
                    ),
                    SizedBox(height: 10),
                    const CustomText(
                      letterSpacing: 1,
                      size: 18,
                      weight: FontWeight.w600,
                      color: Colors.black,
                      text: 'Comments',
                    ),
                    SizedBox(height: 10),
                    CustomText(
                        letterSpacing: 1,
                        size: 16,
                        weight: FontWeight.w400,
                        color: Colors.black,
                        text: description),
                  ]),
            ),
            const SizedBox(height: 30),
            Center(
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: CustomText(
                          letterSpacing: 1,
                          weight: FontWeight.w600,
                          color: Colors.black,
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
                              color: Colors.black,
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
                              color: Colors.blue,
                              text: 'Message',
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.green,
                  ),
                  child: Center(
                    child: Text(
                      'Contact & Verify ',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 0.50,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
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
