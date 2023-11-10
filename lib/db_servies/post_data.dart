import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/screen/company_screens/company_screens.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DbService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static Future<void> uploadDataToFirebase(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    String time,
    File image,
  ) async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      final storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}.jpg');

      await storageReference.putFile(image);

      final imageUrl = await storageReference.getDownloadURL();

      final itemId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(999).toString();

      final Map<String, dynamic> itemData = {
        'itemId': itemId,
        'name': name,
        'description': description,
        'color': color,
        'quantity': quantity,
        'date': date,
        'time': time,
        'image_url': imageUrl,
      };
      _firestore
          .collection('companies')
          .doc('items')
          .collection('item_data')
          .add(itemData);

      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } catch (error) {
      print('Error: $error');
    }
  }
}
