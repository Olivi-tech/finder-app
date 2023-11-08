import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DbService {
  static Future<void> saveDataToFirestore(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    TimeOfDay time,
    String imageUrl,
  ) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('items').add({
      'name': name,
      'quantity': quantity,
      'color': color,
      'date': date,
      'time': time,
      'description': description,
      'image_url': imageUrl,
    });

    print('Data saved to Firestore');
  }

  static Future<String> uploadImageToFirebase(File? image) async {
    if (image != null) {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(image);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      return await storageReference.getDownloadURL();
    } else {
      return "";
    }
  }

  static Future<void> submitData(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    TimeOfDay time,
    File? image,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    String imageUrl = await uploadImageToFirebase(image);
    await saveDataToFirestore(
        context, name, description, color, quantity, date, time, imageUrl);

    Navigator.pop(context);
  }
}




/*class DbService {
  static Future<void> saveDataToFirestore(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    String imageUrl,
  ) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('items').add({
      'name': name,
      'quantity': quantity,
      'color': color,
      'date': date,
      'description': description,
      'image_url': imageUrl,
    });

    print('Data saved to Firestore');
  }

  static Future<String> uploadImageToFirebase(File? image) async {
    if (image != null) {
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageReference.putFile(image);

      await uploadTask.whenComplete(() => print('Image uploaded'));

      return await storageReference.getDownloadURL();
    } else {
      return "";
    }
  }

  static Future<void> submitData(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    File? image,
  ) async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    String imageUrl = await uploadImageToFirebase(image);
    await saveDataToFirestore(
        context, name, description, color, quantity, date, imageUrl);

    Navigator.pop(context);
  }

  static DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
  }
}
*/