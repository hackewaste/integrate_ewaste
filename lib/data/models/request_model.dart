import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  final String requestId;
  final String userId;
  final String? assignedVolunteerId;
  final String? assignedVolunteerName;
  final List<EWasteItem> eWasteItems;
  final int totalCredits;
  final String status;
  final PickupAddress pickupAddress;
  final DateTime createdAt;

  RequestModel({
    required this.requestId,
    required this.userId,
    this.assignedVolunteerId,
    this.assignedVolunteerName,
    required this.eWasteItems,
    required this.totalCredits,
    required this.status,
    required this.pickupAddress,
    required this.createdAt,
  });

  factory RequestModel.fromMap(String requestId, Map<String, dynamic> data) {
    return RequestModel(
      requestId: requestId,
      userId: data['userId'],
      assignedVolunteerId: data['assignedVolunteerId'],
      assignedVolunteerName: data['assignedVolunteerName'],
      eWasteItems: (data['eWasteItems'] as List)
          .map((item) => EWasteItem.fromMap(item))
          .toList(),
      totalCredits: data['totalCredits'],
      status: data['status'],
      pickupAddress: PickupAddress.fromMap(data['pickupAddress']),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}

class EWasteItem {
  final String name;
  final String category;
  final int credits;

  EWasteItem({
    required this.name,
    required this.category,
    required this.credits,
  });

  factory EWasteItem.fromMap(Map<String, dynamic> data) {
    return EWasteItem(
      name: data['name'],
      category: data['category'],
      credits: data['credits'],
    );
  }
}

class PickupAddress {
  final double latitude;
  final double longitude;
  final String address;

  PickupAddress({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory PickupAddress.fromMap(Map<String, dynamic> data) {
    return PickupAddress(
      latitude: data['latitude'],
      longitude: data['longitude'],
      address: data['address'],
    );
  }
}
