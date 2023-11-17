import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/screen/guest_screens.dart/guest_screens.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class GuestItemDetailsPage extends StatelessWidget {
  final String itemId;
  final String image_Url;
  final String name;
  final String description;
  final String color;
  final int quantity;
  // final String date;
  final String time;

  const GuestItemDetailsPage({
    Key? key,
    required this.itemId,
    required this.image_Url,
    required this.name,
    required this.description,
    required this.color,
    required this.quantity,
    required this.time,
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
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: name,
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              const CustomText(
                text: 'Color',
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'White',
              ),
              const SizedBox(height: 10),
              const CustomText(
                text: 'Quantity',
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              CustomText(text: quantity.toString()),
              const SizedBox(height: 10),
              const CustomText(
                text: 'Date & Time',
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CustomText(
                  //text: '27-11-2023',
                  //  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: '|',
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: time,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              CustomText(
                text: 'Description',
                letterSpacing: 1,
                size: 16,
                weight: FontWeight.w600,
              ),
              const SizedBox(height: 10),
              CustomText(text: description),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GuestContactScreen()));
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
                        'Verify its your',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.50,
                          fontSize: 18,
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
            ],
          ),
        ),
      ),
    );
  }
}
