import 'package:cloud_firestore/cloud_firestore.dart';

class ItemData {
  final String itemId;
  final String imageUrl;
  final String category;
  final String name;

  final String brand;
  final int quantity;
  final String color;
//  final String date;
  final String time;
  final String description;
  final String companyName;
  final String companyAddress;

  ItemData({
    required this.quantity,
    // required this.date,
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
  });

  factory ItemData.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ItemData(
      itemId: data['itemId'] ?? '',
      name: data['name'] ?? '',
      imageUrl: data['image_url'] ?? '',
      time: data['time'] ?? '',
      // date: data['date'] ?? '',
      quantity: data['quantity'] ?? '',
      description: data['description'] ?? '',
      color: data['color'] ?? '',
      brand: data['brand'] ?? '',
      category: data['category'] ?? '',
      companyName: data['companyName'] ?? '',
      companyAddress: data['companyAddress'] ?? '',
    );
  }
}
