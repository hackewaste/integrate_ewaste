import 'package:flutter/material.dart';

Widget buildCenteredCard(BuildContext context,{required String title, required List<Widget> children}) {
  return SingleChildScrollView(

    child: Center(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 20),
        color: Colors.teal[100]
        ,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.height * 0.7,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 20),
              ...children,
            ],
          ),
        ),
      ),
    ),
  );
}

Widget buildInputField(TextEditingController controller, String label, IconData icon) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blueAccent, width: 1),
    ),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        icon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget buildDropdownField({required String label, required String value, required List<String> items, required IconData icon, required void Function(String?) onChanged}) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blueAccent, width: 1),
    ),
    child: DropdownButtonFormField(
      value: value,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        icon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget buildSwitchField(String label, bool value, Function(bool) onChanged) {
  return SwitchListTile(
    title: Text(label),
    value: value,
    onChanged: onChanged,
    activeColor: Colors.blueAccent,
  );
}
Widget buildStyledDropdown({
  required String label,
  required String value,
  required List<String> items,
  required IconData icon,
  required void Function(String?) onChanged,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 15),
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.blueAccent, width: 1),
    ),
    child: DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      icon: Icon(Icons.arrow_drop_down, color: Colors.blueAccent),
      decoration: InputDecoration(
        icon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        border: InputBorder.none,
      ),
      dropdownColor: Colors.white,
      style: TextStyle(color: Colors.black, fontSize: 16),
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    ),
  );
}
