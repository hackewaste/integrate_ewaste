import 'package:cloud_firestore/cloud_firestore.dart';

class ResaleItem {
  final String id;
  final String name;
  final int price;
  final String sellerId;
  final String status;
  final DateTime createdAt;

  ResaleItem({required this.id, required this.name, required this.price, required this.sellerId, required this.status, required this.createdAt});

  // Convert Firestore document to ResaleItem object
  factory ResaleItem.fromFirestore(Map<String, dynamic> data, String id) {
    return ResaleItem(
      id: id,
      name: data['name'],
      price: data['price'],
      sellerId: data['sellerId'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert ResaleItem object to Firestore map
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'price': price,
      'sellerId': sellerId,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
