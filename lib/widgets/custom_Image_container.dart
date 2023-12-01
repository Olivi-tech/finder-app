import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imagePath;
  final String containerText;
  final String locationText;
  final String timeText;
  final String dateText;
  final VoidCallback onTap;

  const ImageContainer({
    Key? key,
    required this.imagePath,
    required this.containerText,
    required this.locationText,
    required this.timeText,
    required this.onTap,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: 150,
          width: 300,
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
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  child: Image.network(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 150,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 5, bottom: 10, right: 18),
                      child: Text(
                        containerText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.50,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: AppColors.red,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          locationText,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.50,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: AppColors.blue,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            timeText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.50,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            color: AppColors.blue,
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            dateText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.50,
                              color: AppColors.black,
                            ),
                          ),
                        ],
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
  final String descriptionText;
  final String locationText;
  final String timeText;
  final String dateText;
  final VoidCallback onTap;

  const PostContainer({
    Key? key,
    required this.imagePath,
    required this.containerText,
    required this.timeText,
    required this.onTap,
    required this.descriptionText,
    required this.locationText,
    required this.dateText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                      fit: BoxFit.cover, width: 190, height: 120),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  CustomText(
                    text: containerText,
                    size: 16,
                    weight: FontWeight.w500,
                    letterSpacing: 0.50,
                    color: AppColors.black,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 30,
                    width: 200,
                    child: Text(
                      descriptionText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.50,
                        color: AppColors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.red,
                        size: 16,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        locationText,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.50,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: timeText,
                            size: 14,
                            weight: FontWeight.w300,
                            letterSpacing: 0.50,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month,
                            size: 14,
                          ),
                          const SizedBox(width: 5),
                          CustomText(
                            text: dateText,
                            size: 14,
                            weight: FontWeight.w300,
                            letterSpacing: 0.50,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    ],
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
