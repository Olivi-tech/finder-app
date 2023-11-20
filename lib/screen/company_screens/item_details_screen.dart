import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  final String itemId;
  final String documentId;
  final String image_Url;
  final String category;
  final String brand;
  final String name;
  final String color;
  final int quantity;
  final String time;
  final String description;
  final String companyName;
  final String address;

  ItemDetailsPage({
    required this.itemId,
    required this.documentId,
    required this.image_Url,
    required this.category,
    required this.name,
    required this.brand,
    required this.color,
    required this.quantity,
    required this.time,
    required this.description,
    required this.companyName,
    required this.address,
  });

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
          size: 18,
          weight: FontWeight.w500,
          color: Colors.black,
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
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
