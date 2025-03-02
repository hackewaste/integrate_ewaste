import 'package:ewaste/presentations/user/resale/resale_card.dart';
import 'package:flutter/material.dart';
import '../../../data/models/resale_item.dart';
import '../../../data/services/resale_service.dart';


class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buy Items')),
      body: StreamBuilder<List<ResaleItem>>(
        stream: ResaleService().getResaleItems(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          var items = snapshot.data!;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ResaleCard(item: items[index]);
            },
          );
        },
      ),
    );
  }
}
