import 'package:finder_app/constants/constants.dart';

class CompanyData {
  final String name;
  final String category;
  final String crNumber;
  final String email;
  final String password;
  final String phoneNo;
  final String country;
  final String city;
  final String address;
  final String roleMode;

  CompanyData({
    required this.name,
    required this.category,
    required this.crNumber,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.country,
    required this.address,
    required this.city,
    required this.roleMode,
  });

  Map<String, dynamic> toJson() {
    return {
      AppText.name: name,
      AppText.category: category,
      AppText.crNumber: crNumber,
      AppText.email: email,
      AppText.password: password,
      AppText.phoneNumber: phoneNo,
      AppText.address: address,
      AppText.country: country,
      AppText.city: city,
      AppText.roleModel: roleMode,
    };
  }
}
