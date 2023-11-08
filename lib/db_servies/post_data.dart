import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/db_servies/exceptions_handle.dart';
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
    String time,
    String imageUrl,
  ) async {
    try {
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
    } catch (error) {
      if (error is HttpException ||
          error is SocketException ||
          error is FormatException) {
        ErrorHandling.handleErrors(error: error);
      } else {
        rethrow;
      }
    }
  }

  static Future<String> uploadImageToFirebase(File? image) async {
    try {
      if (image != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');
        final UploadTask uploadTask = storageReference.putFile(image);

        await uploadTask.whenComplete(() => print('Image uploaded'));

        return await storageReference.getDownloadURL();
      }
    } catch (error) {
      if (error is HttpException ||
          error is SocketException ||
          error is FormatException) {
        ErrorHandling.handleErrors(error: error);
      } else {
        rethrow;
      }
    }

    return '';
  }

  static Future<void> submitData(
    BuildContext context,
    String name,
    String description,
    String color,
    int quantity,
    DateTime date,
    String time,
    File? image,
  ) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return Center(child: CircularProgressIndicator());
          });

      String imageUrl = await uploadImageToFirebase(image);
      await saveDataToFirestore(
          context, name, description, color, quantity, date, time, imageUrl);

      Navigator.pop(context);
    } catch (error) {
      if (error is HttpException ||
          error is SocketException ||
          error is FormatException) {
        ErrorHandling.handleErrors(error: error);
      } else {
        rethrow;
      }
    }
  }
}
