import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ewaste/presentations/volunteer/requests/widgets/volbackloc.dart';
import 'package:flutter/material.dart';
import '../../../data/models/request_model.dart';


class WasteVerificationPage extends StatefulWidget {
  final String requestId;
  const WasteVerificationPage({Key? key, required this.requestId}) : super(key: key);

  @override
  _WasteVerificationPageState createState() => _WasteVerificationPageState();
}

class _WasteVerificationPageState extends State<WasteVerificationPage> {
  String? userName;
  List<String> itemNames = [];
  int? creditPoints;

  @override
  void initState() {
    super.initState();
    _fetchRequestData();
  }

  Future<void> _fetchRequestData() async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot requestSnapshot =
          await firestore.collection("requests").doc(widget.requestId).get();

      if (requestSnapshot.exists) {
        var requestData = requestSnapshot.data() as Map<String, dynamic>;
        String userId = requestData['userId'];

        DocumentSnapshot userSnapshot =
            await firestore.collection("Users").doc(userId).get();

        String userNameFetched =
            userSnapshot.exists ? userSnapshot['name'] : 'Unknown';

        setState(() {
          userName = userNameFetched;
          itemNames = List<String>.from(requestData['eWasteItems']
              .map((item) => item['name']));
          creditPoints = requestData['totalCredits'];
        });
      }
    } catch (e) {
      print("Error fetching request data: $e");
    }
  }

  Future<void> completeRequest(BuildContext context) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot requestSnapshot =
          await firestore.collection("requests").doc(widget.requestId).get();

      if (!requestSnapshot.exists) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Request not found!")));
        return;
      }

      RequestModel request = RequestModel.fromMap(
          requestSnapshot.id, requestSnapshot.data() as Map<String, dynamic>);

      String userId = request.userId;
      int totalCredits = request.totalCredits;

      DocumentReference userRef = firestore.collection("Users").doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User not found!")));
        return;
      }

      int currentCredits = (userSnapshot["credits"] ?? 0) as int;
      int updatedCredits = currentCredits + totalCredits;

      await userRef.update({"credits": updatedCredits});
      await firestore.collection("requests").doc(widget.requestId).update({"status": "pickedup"});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("E-Waste Verified & Credits Updated!")),
      );

      Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => MapPage()),
);
    } catch (e) {
      print("❌ Error completing request: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error completing request!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("E-Waste Verification")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("User: ${userName ?? 'Loading...'}",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("E-Waste Items:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    ...itemNames.map((item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "• $item",
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Credits: ${creditPoints ?? 'Loading...'}",
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () => completeRequest(context),
                child: Text("E-Waste Verified"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
