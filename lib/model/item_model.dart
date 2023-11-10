
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemData {
  final String itemId;
  final String imageUrl;
  final String time;
  final String name;
  final String color;
  final int quantity;
  // final String date;
  final String description;

  ItemData({
    required this.quantity,
    //  required this.date,
    required this.description,
    required this.itemId,
    required this.name,
    required this.imageUrl,
    required this.time,
    required this.color,
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
    );
  }
}
