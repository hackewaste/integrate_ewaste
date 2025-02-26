import 'package:ewaste/presentations/user/B2B/Details/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';


class PickupLogisticsSection extends StatefulWidget {
  @override
  _PickupLogisticsSectionState createState() => _PickupLogisticsSectionState();
}

class _PickupLogisticsSectionState extends State<PickupLogisticsSection> {
  bool _requiresLoadingAssistance = false;
  TextEditingController _pickupAddressController = TextEditingController();
  TextEditingController dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return buildCenteredCard(

      context,
      title: "Pickup & Logistics",
      children: [
        buildInputField(_pickupAddressController, "Pickup Address", Icons.location_on),
        buildInputField(dateTimeController, "Pickup Date & Time", Icons.calendar_today),
        buildSwitchField(
          "Requires Loading Assistance",
          _requiresLoadingAssistance,
              (bool value) {
            setState(() {
              _requiresLoadingAssistance = value;
            });
          },
        ),
      ],
    );
  }
}
