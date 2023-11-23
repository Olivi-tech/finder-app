import 'package:cloud_firestore/cloud_firestore.dart';

class ItemData {
  final String itemId;
  final String imageUrl;
  final String category;
  final String name;
  final String brand;
  final int quantity;
  final String color;
  final DateTime date;
  final String time;
  final String description;
  final String companyName;
  final String companyAddress;
  final String companyCountry;
  final String companyPhone;

  ItemData({
    required this.quantity,
    required this.date,
    required this.category,
    required this.brand,
    required this.description,
    required this.itemId,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.color,
    required this.companyName,
    required this.companyAddress,
    required this.companyCountry,
    required this.companyPhone,
  });

  factory ItemData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    DateTime date = (data['date'] as Timestamp).toDate();

    return ItemData(
      itemId: data['itemId'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['image_url'] ?? '',
      time: data['time'] ?? '',
      date: date,
      quantity: data['quantity'] ?? 0,
      description: data['description'] ?? '',
      color: data['color'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      companyName: data['companyName'] ?? '',
      companyAddress: data['companyAdress'] ?? '',
      companyCountry: data['companyCountry'] ?? '',
      companyPhone: data['companPhoneNo'] ?? '',
    );
  }
}
