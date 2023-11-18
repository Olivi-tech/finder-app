import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/widget/widget.dart';
import 'package:flutter/material.dart';

class ItemDetailsPage extends StatelessWidget {
  final String itemId;
  final String documentId;
  final String image_Url;
  final String name;
  final String description;
  final String color;
  final int quantity;
  final String time;

  ItemDetailsPage({
    required this.itemId,
    required this.image_Url,
    required this.name,
    required this.description,
    required this.color,
    required this.quantity,
    required this.time,
    required this.documentId,
  });

  Future<void> _deleteItem(String documentId, BuildContext context) async {
    try {
      await FirebaseFirestore.instance
          .collection('companies')
          .doc('items')
          .collection('item_data')
          .doc(documentId)
          .delete();
    } catch (error) {
      print('Error deleting item: $error');
    }
  }

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
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
              size: 28,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Delete'),
                    content: const Text(
                        'Are you sure you want to delete this item?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _deleteItem(documentId, context);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: CustomText(
                          letterSpacing: 1,
                          weight: FontWeight.w600,
                          color: Colors.red,
                          text: 'Delete',
                        ),
                      ),
                    ],
                  );
                },
              );
            },
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
      ),
    );
  }
}
