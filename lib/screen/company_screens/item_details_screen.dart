import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  final String itemId;
  final String image_Url;
  final String name;
  final String description;
  final String color;
  final int quantity;
  // final String date;
  final String time;
  ItemDetailsPage(
      {required this.itemId,
      required this.image_Url,
      required this.name,
      required this.description,
      required this.color,
      required this.quantity,
      //  required this.date,
      required this.time});

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
            letterSpacing: 1,
            size: 16,
            weight: FontWeight.w600,
            color: Colors.black,
            text: 'Item Details',
          ),
          actions: [
            const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 20),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                SizedBox(height: 40),
                CustomText(
                    letterSpacing: 1,
                    size: 18,
                    weight: FontWeight.w600,
                    color: Colors.black,
                    text: name),
                SizedBox(height: 10),
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
                SizedBox(height: 10),
                const CustomText(
                  letterSpacing: 1,
                  size: 16,
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
                SizedBox(height: 10),
                const CustomText(
                  letterSpacing: 1,
                  size: 16,
                  weight: FontWeight.w600,
                  color: Colors.black,
                  text: 'Date & Time',
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(date),
                    SizedBox(width: 10),
                    CustomText(
                        letterSpacing: 1,
                        size: 16,
                        weight: FontWeight.w400,
                        color: Colors.black,
                        text: '|'),
                    SizedBox(width: 10),
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
                  size: 16,
                  weight: FontWeight.w600,
                  color: Colors.black,
                  text: 'Description',
                ),
                SizedBox(height: 10),
                CustomText(
                    letterSpacing: 1,
                    size: 16,
                    weight: FontWeight.w400,
                    color: Colors.black,
                    text: description),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}
