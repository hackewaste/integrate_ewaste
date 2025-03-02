import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/presentations/user/home/widgets/userrequestpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> userRequests = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserRequests();
  }

  Future<void> fetchUserRequests() async {
    setState(() => isLoading = true);

    User? user = _auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await _firestore
          .collection("requests")
          .where("userId", isEqualTo: user.uid)
          .get();

      setState(() {
        userRequests = querySnapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

          // Extract eWaste items list
          List<Map<String, dynamic>> eWasteItems = [];
          if (data.containsKey('eWasteItems') && data['eWasteItems'] is List) {
            eWasteItems = List<Map<String, dynamic>>.from(data['eWasteItems']);
          }

          return {
            'requestId': doc.id,
            'status': data['status'] ?? 'Unknown',
            'totalCredits': data['totalCredits'] ?? 0,
            'eWasteItems': eWasteItems,
          };
        }).toList();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              "User Menu",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("My Requests"),
            onTap: () async {
              await fetchUserRequests(); // Fetch latest data when tapped
              if (userRequests.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserRequestsPage(userRequests: userRequests),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No requests found.")),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
