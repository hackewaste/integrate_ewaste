import 'package:ewaste/presentations/user/detection/widgets/OTPSection.dart';
import 'package:ewaste/presentations/user/detection/widgets/request_summary_card.dart';
import 'package:ewaste/presentations/user/detection/widgets/status_section.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/request_model.dart';
import '../../../data/services/request_fetch_service.dart';


class PickupRequestStatusPage extends StatefulWidget {
  final String requestId;

  const PickupRequestStatusPage({Key? key, required this.requestId}) : super(key: key);

  @override
  _PickupRequestStatusPageState createState() => _PickupRequestStatusPageState();
}

class _PickupRequestStatusPageState extends State<PickupRequestStatusPage> {
  RequestModel? requestModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRequestDetails();
  }

  Future<void> fetchRequestDetails() async {
    print("🔍 Fetching request details for ID: ${widget.requestId}");

    RequestModel? request = await RequestFetchService().getRequestDetails(widget.requestId);

    setState(() {
      requestModel = request;
      isLoading = false;
    });

    if (request == null) {
      print("❌ Request not found: ${widget.requestId}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pickup Request Status", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: isLoading
          ? _buildLoading()
          : requestModel == null
          ? _buildError()
          : _buildContent(),
    );
  }

  /// 📌 **Loading UI**
  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.green,
        strokeWidth: 4,
      ),
    );
  }

  /// ❌ **Error UI**
  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/animations/error.json', width: 200), // 🔥 Use a cool animation!
          const SizedBox(height: 10),
          const Text(
            "Oops! Request not found.",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }

  /// ✅ **Main Content UI**
  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// 🏷️ **Status Card**
          StatusSection(requestId: widget.requestId),

          const SizedBox(height: 20),

          /// 📦 **Order Summary Card**
          SummaryCard(requestId: widget.requestId),
          const SizedBox(height: 20),
          OTPSection(requestId: widget.requestId),// Pass requestId here

        ],
      ),
    );
  }
}
