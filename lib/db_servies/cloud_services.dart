import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../model/item_model.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';
import 'db_servies.dart';

class CloudServices {
  static final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  static CollectionReference getItemCollection() {
    var collection = _fireStore.collection(AppText.itemCollection);

    return collection;
  }

  static Future<DocumentSnapshot> fetchCompanyData() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    DocumentSnapshot companySnapshot =
        await _fireStore.collection(AppText.userDataCollection).doc(uid).get();
    return companySnapshot;
  }

  static Future<void> uploadDataToFirebase({
    required BuildContext context,
    required File image,
    required String category,
    required String name,
    required String brand,
    required int quantity,
    required String color,
    required String date,
    required String time,
    required String description,
  }) async {
    try {
      String? uid = FirebaseAuth.instance.currentUser?.uid;
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('item_image/$uid/${DateTime.now().microsecondsSinceEpoch}');
      await storageReference.putFile(image);
      final imageUrl = await storageReference.getDownloadURL();
      final itemId = DateTime.now().millisecondsSinceEpoch.toString() +
          Random().nextInt(999).toString();
      var data = await fetchCompanyData();

      var itemModel = ItemData(
        itemId: itemId,
        time: time,
        name: name,
        color: color,
        brand: brand,
        category: category,
        companyAddress: data[AppText.address],
        companyCountry: data[AppText.country],
        companyName: data[AppText.name],
        companyPhone: data[AppText.phoneNumber],
        date: DateTime.parse(date),
        description: description,
        imageUrl: imageUrl,
        quantity: quantity,
      );

      await _fireStore
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
