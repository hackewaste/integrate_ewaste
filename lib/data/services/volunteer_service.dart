import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class VolunteerService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all volunteers' information
  Future<List<Map<String, dynamic>>> getVolunteers() async {
    try {
      QuerySnapshot volunteerSnapshot = await _firestore.collection('volunteers').get();
      List<Map<String, dynamic>> volunteers = [];

      volunteerSnapshot.docs.forEach((doc) {
        volunteers.add(doc.data() as Map<String, dynamic>);
      });

      return volunteers;
    } catch (e) {
      print('Error getting volunteers: $e');
      return [];
    }
  }

  // Calculate the distance between two geographic locations
  Future<double> calculateDistance(
      double userLatitude, double userLongitude, double volunteerLatitude, double volunteerLongitude) async {
    try {
      double distance = await Geolocator.distanceBetween(userLatitude, userLongitude, volunteerLatitude, volunteerLongitude);
      return distance;
    } catch (e) {
      print('Error calculating distance: $e');
      return double.infinity;
    }
  }

  // Get the 3 closest volunteers to the request
  Future<List<Map<String, dynamic>>> getClosestVolunteers(
      double pickupLatitude, double pickupLongitude) async {
    List<Map<String, dynamic>> volunteers = await getVolunteers();

    // Sort volunteers by proximity to the request
    volunteers.sort((a, b) async {
      double distanceA = await calculateDistance(pickupLatitude, pickupLongitude, a['location']['latitude'], a['location']['longitude']);
      double distanceB = await calculateDistance(pickupLatitude, pickupLongitude, b['location']['latitude'], b['location']['longitude']);
      return distanceA.compareTo(distanceB);
    });

    // Return the 3 closest volunteers
    return volunteers.take(3).toList();
  }

  // Assign a volunteer to the request and update their status
  Future<void> assignVolunteerToRequest(String requestId, String volunteerId) async {
    try {
      // Get the volunteer's data
      DocumentSnapshot volunteerDoc = await _firestore.collection('volunteers').doc(volunteerId).get();
      if (!volunteerDoc.exists) {
        print('Volunteer does not exist');
        return;
      }

      Map<String, dynamic> volunteerData = volunteerDoc.data() as Map<String, dynamic>;

      // Update the volunteer's pending deliveries and current request ID
      await _firestore.collection('volunteers').doc(volunteerId).update({
        'pendingDeliveries': FieldValue.arrayUnion([requestId]),
        'currentRequestId': requestId,
        'status': 'on-duty',
      });

      // Update the request's assigned volunteer ID and status
      await _firestore.collection('requests').doc(requestId).update({
        'assignedVolunteerId': volunteerId,
        'status': 'assigned',
      });

      print('Volunteer $volunteerId assigned to request $requestId');
    } catch (e) {
      print('Error assigning volunteer: $e');
    }
  }

  // Remove a request from the volunteer's pending deliveries list when it is accepted
  Future<void> removeRequestFromPendingDeliveries(String volunteerId, String requestId) async {
    try {
      // Remove the request from the volunteer's pending deliveries
      await _firestore.collection('volunteers').doc(volunteerId).update({
        'pendingDeliveries': FieldValue.arrayRemove([requestId]),
      });
      print('Request $requestId removed from volunteer $volunteerId\'s pending deliveries');
    } catch (e) {
      print('Error removing request from pending deliveries: $e');
    }
  }

  // Update the volunteer's status to "off-duty" when the request is completed
  Future<void> completeRequest(String volunteerId, String requestId) async {
    try {
      // Update volunteer's status to "off-duty"
      await _firestore.collection('volunteers').doc(volunteerId).update({
        'status': 'off-duty',
        'currentRequestId': null,
      });

      // Update the request status to "completed"
      await _firestore.collection('requests').doc(requestId).update({
        'status': 'completed',
      });

      print('Request $requestId completed by volunteer $volunteerId');
    } catch (e) {
      print('Error completing request: $e');
    }
  }
}
