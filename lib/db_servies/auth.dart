import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/db_servies/exceptions_handle.dart';
import 'package:finder_app/model/model.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DbService_auth {
  static FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> registerCompany(
    BuildContext context,
    String name,
    String email,
    String password,
    String phoneNo,
    String country,
    String address,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      await user?.updateDisplayName(name);

      final companyData = CompanyData(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        country: country,
        address: address,
      );

      await FirebaseFirestore.instance
          .collection('companies')
          .doc(user?.uid)
          .set({
        'name': companyData.name,
        'email': companyData.email,
        'password': companyData.password,
        'phoneNo': companyData.phoneNo,
        'country': companyData.country,
        'address': companyData.address,
      });

      log('User registered and company data saved');

      Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
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

  static Future<User?> loginCompany(
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
      Navigator.of(context).pushReplacementNamed(AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _showAlertDialog(context, 'Invalid Credentials',
            'No user found for that email & password.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<void> registerUser(
    BuildContext context,
    String name,
    String email,
    String password,
    String phoneNo,
    String country,
    String address,
  ) async {
    try {
      if (await isEmailUsedForCompany(email)) {
        _showAlertDialog(
          context,
          'Email Already Used',
          'The email is already registered as a company. Please use a different email.',
        );
        ;
      }
      User? user;
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await userCredential.user?.updateDisplayName(name);
      final userData = UserData(
        name: name,
        email: email,
        password: password,
        phoneNo: phoneNo,
        country: country,
        address: address,
      );

      await FirebaseFirestore.instance
          .collection('userData')
          .doc(user?.uid)
          .set({
        'name': userData.name,
        'email': userData.email,
        'password': userData.password,
        'country': userData.country,
        'address': userData.address,
        'phoneNo': userData.phoneNo,
      });

      log('User registered');
      Navigator.of(context).pushReplacementNamed(AppRoutes.guesthome);
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

  static Future<User?> loginUser(
    BuildContext context,
    String email,
    String password,
  ) async {
    User? user;

    try {
      if (await isEmailUsedForCompany(email)) {
        _showAlertDialog(
          context,
          'Email Already Used',
          'The email is already registered as a company. Please use a different email.',
        );
        ;
      }
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      log('User logged in');
      Navigator.of(context).pushReplacementNamed(AppRoutes.guesthome);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _showAlertDialog(context, 'Invalid Credentials',
            'No user found for that email & password.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<bool> isEmailUsedForCompany(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('companies')
          .where('email', isEqualTo: email)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (error) {
      return false;
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
