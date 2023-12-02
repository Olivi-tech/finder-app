import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static Future<String> getImageFromGallery() async {
    final pickedFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      File image = File(pickedFile.path);
      return image.path;
    } else {
      return '';
    }
  }


 static  String formatDateWithoutTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}
