import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constant/constant.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DbService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<void> uploadDataToFirebase(
    BuildContext context,
    File image,
    String category,
    String name,
    String brand,
    int quantity,
    String color,
    DateTime date,
    String time,
    String description,
    String companyName,
    String companyAdress,
  ) async {
    try {
      final storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

      await storageReference.putFile(image);

      final imageUrl = await storageReference.getDownloadURL();

      final itemId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(999).toString();

      final Map<String, dynamic> itemData = {
        'itemId': itemId,
        'image_url': imageUrl,
        'category': category,
        'name': name,
        'brand': brand,
        'quantity': quantity,
        'color': color,
        'date': date,
        'time': time,
        'description': description,
        'companyName': companyName,
        'companyAdress': companyAdress,
      };
      await _firestore
          .collection('companies')
          .doc('items')
          .collection('item_data')
          .add(itemData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.green,
          content: Text(
            'Uploaded data Sucessfully',
            style: TextStyle(color: Colors.white),
          ),
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushNamed(AppRoutes.homePage);
    } catch (error) {
      print('Error: $error');
    }
  }
}
