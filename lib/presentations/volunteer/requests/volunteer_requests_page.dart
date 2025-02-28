import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ewaste/data/services/volunteer_service.dart';

class VolunteerRequestsPage extends StatefulWidget {
  @override
  _VolunteerRequestsPageState createState() => _VolunteerRequestsPageState();
}

class _VolunteerRequestsPageState extends State<VolunteerRequestsPage> {
  final VolunteerRequestService _volunteerService = VolunteerRequestService();
  List<Map<String, dynamic>> _requests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    List<Map<String, dynamic>> requests = await _volunteerService.getPendingRequests();
    setState(() {
      _requests = requests;
      _isLoading = false;
    });
  }

  Future<void> _acceptRequest(String requestId) async {
    User? user = FirebaseAuth.instance.currentUser; // Get logged-in volunteer
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Not logged in! Please sign in first.")),
      );
      return;
    }

    String volunteerId = user.uid; // Firebase UID
    String? volunteerName = user.displayName; // Get name if set

    if (volunteerName == null) {
      // Fetch from Firestore if `displayName` is not available
      volunteerName = await _volunteerService.getVolunteerName(volunteerId);
    }

    bool success = await _volunteerService.acceptRequest(
      requestId: requestId,
      volunteerId: volunteerId,
      volunteerName: volunteerName ?? "Unknown",
    );

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Request Accepted!")),
      );
      _loadRequests(); // Refresh list
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to accept request.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Available Pickup Requests")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _requests.isEmpty
          ? const Center(child: Text("No pending requests available."))
          : ListView.builder(
        itemCount: _requests.length,
        itemBuilder: (context, index) {
          var request = _requests[index];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("Request ID: ${request['id']}"),
              subtitle: Text("Credits: ${request['totalCredits']}"),
              trailing: ElevatedButton(
                onPressed: () => _acceptRequest(request['id']),
                child: const Text("Accept"),
              ),
            ),
          );
        },
      ),
    );
  }
}
