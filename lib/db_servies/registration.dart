import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finder_app/db_servies/exceptions_handle.dart';

class DbService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> registerCompany(
      String name,
      String email,
      String password,
      String country,
      String city,
      String address,
      String phoneNo) async {
    try {
      await _firestore
          .collection('user')
          .doc('001')
          .collection('company')
          .doc('company_credentials')
          .set({
        'name': name,
        'email': email,
        'password': password,
        'country': country,
        'city': city,
        'address': address,
        'phoneNo': phoneNo,
      });
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
