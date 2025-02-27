import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/ewaste_item.dart';

class FirebaseService {
  static Future<List<EWasteItem>> fetchEWasteItems() async {
    List<EWasteItem> items = [];
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('eWasteItems').get();
    for (var doc in snapshot.docs) {
      items.add(EWasteItem.fromMap(doc.data() as Map<String, dynamic>));
    }
    return items;
  }
}
