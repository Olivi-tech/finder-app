import 'dart:developer';
import 'dart:io';
import 'package:finder_app/db_servies/exceptions_handle.dart';
import 'package:finder_app/utils/app_routs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DbService_auth {
  static Future<void> registerCompany(
    BuildContext context,
    String name,
    String email,
    String password,
    String country,
    String city,
    String address,
    String phoneNo,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await userCredential.user?.updateDisplayName(name);

      log('User registered and company data saved');
      Navigator.of(context).pushNamed(AppRoutes.homePage);
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

  static Future<User?> loginCompany(
    BuildContext context,
    String email,
    String password,
  ) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      Navigator.pushNamed(context, AppRoutes.homePage);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}
