import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final String containerText;
  final String locationText;
  final String timeText;
  final VoidCallback onTap;
  const ImageContainer({
    Key? key,
    required this.imagePath,
    required this.containerText,
    required this.locationText,
    required this.timeText,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 250,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: const Offset(0, 2),
                blurRadius: 1.0,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: Image.network(imagePath,
                      fit: BoxFit.cover,
                      width: MediaQuery.sizeOf(context).width,
                      height: 100),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 8, bottom: 10),
                child: Text(
                  containerText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.50,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      locationText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.50,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.blue,
                      size: 14,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      timeText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.50,
                        color: Colors.black,
                      ),
                    ),
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

class PostContainer extends StatelessWidget {
  final String imagePath;
  final String containerText;
  final String describtionText;
  final String timeText;
  final VoidCallback onTap;
  final VoidCallback ontapcontact;
  const PostContainer({
    Key? key,
    required this.imagePath,
    required this.containerText,
    required this.timeText,
    required this.onTap,
    required this.describtionText,
    required this.ontapcontact,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 160,
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: const Offset(0, 2),
              blurRadius: 1.0,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(imagePath,
                      fit: BoxFit.cover, width: 190, height: 150),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  CustomText(
                    text: containerText,
                    size: 16,
                    weight: FontWeight.w500,
                    letterSpacing: 0.50,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    height: 50,
                    width: 200,
                    child: Text(
                      describtionText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.50,
                        color: Colors.black,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                      ),
                      const SizedBox(width: 2),
                      CustomText(
                        text: timeText,
                        size: 14,
                        weight: FontWeight.w300,
                        letterSpacing: 0.50,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: ontapcontact,
                    child: Container(
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.green,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.call,
                            size: 14,
                            color: Colors.white,
                          ),
                          CustomText(
                            text: 'Contact',
                            size: 14,
                            weight: FontWeight.w500,
                            letterSpacing: 0.50,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
