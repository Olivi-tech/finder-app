import '../constants/constants.dart';

class UserData {
  final String name;
  final String email;
  final String password;
  final String phoneNo;
  final String country;
  final String address;
  final String roleMode;
  var image;

  UserData({
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.address,
    required this.phoneNo,
    required this.roleMode,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      AppText.name: name,
      AppText.email: email,
      AppText.password: password,
      AppText.phoneNumber: phoneNo,
      AppText.address: address,
      AppText.country: country,
      AppText.image: image,
      AppText.roleModel: roleMode,
    };
  }
}
