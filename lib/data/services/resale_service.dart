import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/resale_item.dart';

class ResaleService {
  final CollectionReference resaleCollection = FirebaseFirestore.instance.collection('resale_items');

  // Add a new resale item
  Future<void> addResaleItem(String name, int price, String sellerId) async {
    await resaleCollection.add({
      'name': name,
      'price': price,
      'sellerId': sellerId,
      'status': 'available',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Fetch available resale items
  Stream<List<ResaleItem>> getResaleItems() {
    return resaleCollection.where('status', isEqualTo: 'available').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => ResaleItem.fromFirestore(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Mark item as pending for verification
  Future<void> requestToBuy(String itemId) async {
    await resaleCollection.doc(itemId).update({'status': 'pending'});
  }
}
