import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
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
      bool _isLoading = true;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 150,
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isLoading
                      ? const CupertinoActivityIndicator(
                          color: Colors.green,
                          radius: 25,
                        )
                      : const Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 50,
                        ),
                  const SizedBox(height: 20),
                  Text(
                    _isLoading ? 'Uploading data...' : 'Done',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          );
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
      await _firestore
          .collection('companies')
          .doc('items')
          .collection('item_data')
          .add(itemData);

      _isLoading = false;

      Navigator.pop(context);
      Navigator.pushNamed(context, AppRoutes.homePage);
    } catch (error) {
      print('Error: $error');
    }
  }
}
