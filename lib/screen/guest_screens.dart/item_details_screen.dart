import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class GuestItemDetailsPage extends StatelessWidget {
  final String containerText;
  final String locationText;
  final String timeText;
  final String imagePath;

  const GuestItemDetailsPage({
    Key? key,
    required this.containerText,
    required this.timeText,
    required this.imagePath,
    required this.locationText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
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
                    image: AssetImage(imagePath),
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
                      text: containerText,
                      letterSpacing: 1,
                      size: 16,
                      weight: FontWeight.w600,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        CustomText(
                          text: locationText,
                        ),
                        const SizedBox(width: 16),
                        Icon(
                          Icons.access_time,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        CustomText(
                          text: timeText,
                        ),
                      ],
                    ),
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
              CustomText(
                text: '1',
              ),
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
                  CustomText(
                    text: '27-11-2023',
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: '|',
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    text: '6:30 Pm',
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
              CustomText(
                text:
                    'We found an iPhone 11. It appears to be in good condition and is locked, so We cant access any contact information to return it to its owner.',
              ),
              const SizedBox(height: 10),
              CustomButton(
                text: 'Verify its Your',
                btnColor: AppColors.green,
                textColor: Colors.white,
                onPressed: () {},
                width: size.width,
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
