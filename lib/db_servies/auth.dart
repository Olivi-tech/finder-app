import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/db_servies/exceptions_handle.dart';
import 'package:finder_app/model/model.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

class DbService_auth {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<void> registerCompany(
    BuildContext context,
    String name,
    String category,
    String crNumber,
    String email,
    String password,
    String phoneNo,
    String country,
    String city,
    String address,
    String roleMode,
  ) async {
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      final companyData = CompanyData(
        name: name,
        category: category,
        email: email,
        password: password,
        phoneNo: phoneNo,
        country: country,
        city: city,
        address: address,
        roleMode: roleMode,
        crNumber: crNumber,
      );

      await FirebaseFirestore.instance
          .collection(AppText.userDataCollection)
          .doc(user?.uid)
          .set(companyData.toJson());

      log('User registered and company data saved');

      Navigator.of(context).pushReplacementNamed(AppRoutes.companyHome);
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          _showAlertDialog(context, 'Email Already Exists',
              'The account already exists for that email.');
        } else if (error.code == ' Password should be at least 6 characters ') {
          _showAlertDialog(context, 'Weak Password',
              'The password provided is too weak. Password must have at least 6 characters.');
        }
      } else if (error is HttpException ||
          error is SocketException ||
          error is FormatException) {
        ErrorHandling.handleErrors(error: error);
      } else {
        rethrow;
      }
    }
  }

  static Future<void> registerUser(
    BuildContext context,
    File image,
    String name,
    String email,
    String password,
    String phoneNo,
    String country,
    String address,
    String roleMode,
  ) async {
    try {
      User? user;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now()}');

      await storageReference.putFile(image);
      final imageUrl = await storageReference.getDownloadURL();
      user = userCredential.user;
      final userData = UserData(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        country: country,
        address: address,
        roleMode: roleMode,
        image: imageUrl,
      );

      await FirebaseFirestore.instance
          .collection(AppText.userDataCollection)
          .doc(user?.uid)
          .set(userData.toJson());

      log('User registered');
      Navigator.of(context).pushReplacementNamed(AppRoutes.guestHome);
    } catch (error) {
      if (error is FirebaseAuthException) {
        if (error.code == 'email-already-in-use') {
          _showAlertDialog(context, 'Email Already Exists',
              'The account already exists for that email.');
        } else if (error.code == 'weak-password') {
          _showAlertDialog(context, 'Weak Password',
              'The password provided is too weak. Password must have at least 6 characters.');
        }
      } else if (error is HttpException ||
          error is SocketException ||
          error is FormatException) {
        ErrorHandling.handleErrors(error: error);
      } else {
        rethrow;
      }
    }
  }

  static Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    User? user;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection(AppText.userDataCollection)
          .doc(user?.uid)
          .get();

      String roleMode = userDataSnapshot.get(AppText.roleModel);

      if (roleMode == 'User') {
        Navigator.of(context).pushReplacementNamed(AppRoutes.guestHome);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoutes.companyHome);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _showAlertDialog(context, 'Invalid Credentials',
            'No user found for that email & password.');
      }
    } catch (e) {
      print(e);
    }
  }

  static void _showAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
