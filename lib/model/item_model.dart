import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/constants.dart';

class ItemData {
  final String itemId;
  final String imageUrl;
  final String category;
  final String name;
  final String brand;
  final String series;
  final int quantity;
  final String color;
  final DateTime date;
  final String time;
  final String description;
  final String companyName;
  final String companyCity;
  final String companyCategory;
  final String companyCountry;
  final String companyPhone;

  ItemData({
    required this.quantity,
    required this.date,
    required this.category,
    required this.brand,
    required this.series,
    required this.description,
    required this.itemId,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.color,
    required this.companyName,
    required this.companyCity,
    required this.companyCategory,
    required this.companyCountry,
    required this.companyPhone,
  });

  factory ItemData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    DateTime date = (data[AppText.date] as Timestamp).toDate();

    return ItemData(
      companyCategory: data[AppText.companyCategory] ?? '',
      series: data[AppText.series] ?? '',
      itemId: data[AppText.itemID] ?? '',
      name: data[AppText.name] ?? '',
      imageUrl: data[AppText.image] ?? '',
      time: data[AppText.time] ?? '',
      date: date,
      quantity: data[AppText.quantity] ?? 0,
      description: data[AppText.description] ?? '',
      color: data[AppText.color] ?? '',
      brand: data[AppText.brand] ?? '',
      category: data[AppText.category] ?? '',
      companyName: data[AppText.companyName] ?? '',
      companyCity: data[AppText.companyCity] ?? '',
      companyCountry: data[AppText.companyCountry] ?? '',
      companyPhone: data[AppText.companyPhoneNumber] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AppText.companyCategory :  companyCategory,
      AppText.series :  series,
      AppText.itemID: itemId,
      AppText.image: imageUrl,
      AppText.category: category,
      AppText.name: name,
      AppText.brand: brand,
      AppText.quantity: quantity,
      AppText.color: color,
      AppText.date: date,
      AppText.time: time,
      AppText.description: description,
      AppText.companyName: companyName,
      AppText.companyCity: companyCity,
      AppText.companyCountry: companyCountry,
      AppText.companyPhoneNumber: companyPhone,
    };
  }
}
