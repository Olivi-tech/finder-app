import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/constants/constants.dart';
import 'package:finder_app/db_servies/exceptions_handle.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:finder_app/widgets/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../model/model.dart';

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
    String companyAddress,
    String companyCountry,
    String companyPhoneNo,
  ) async {
    try {
      // final querySnapshot = await _firestore
      //     .collection('companies')
      //     .doc('items')
      //     .collection('item_data')
      //     .where('name', isEqualTo: name)
      //     .where('brand', isEqualTo: brand)
      //     .where('color', isEqualTo: color)
      //     .get();
      //
      // if (querySnapshot.docs.isNotEmpty) {
      //   CustomSnackBar.show(
      //     context: context,
      //     text: 'Item with the same attributes already exists!',
      //     backgroundColor: AppColors.red,
      //   );
      //   return;
      // }

      final storageReference =
          FirebaseStorage.instance.ref().child('images/${DateTime.now()}');

      await storageReference.putFile(image);
      final imageUrl = await storageReference.getDownloadURL();
      final itemId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(999).toString();

      var itemModel = ItemData(
        itemId: itemId,
        time: time,
        name: name,
        color: color,
        brand: brand,
        category: category,
        companyAddress: companyAddress,
        companyCountry: companyCountry,
        companyName: companyName,
        companyPhone: companyPhoneNo,
        date: date,
        description: description,
        imageUrl: imageUrl,
        quantity: quantity,
      );

      await _firestore
          .collection(AppText.itemCollection)
          .add(itemModel.toJson());

      CustomSnackBar.show(
        context: context,
        text: 'Uploaded data Successfully',
        backgroundColor: AppColors.green,
      );

      Navigator.of(context).pushReplacementNamed(AppRoutes.companyHome);
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
