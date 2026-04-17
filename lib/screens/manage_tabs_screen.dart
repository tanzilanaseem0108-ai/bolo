import 'package:flutter/material.dart';
import '../models/category_model.dart';

class ManageTabsScreen extends StatefulWidget {
  @override
  _ManageTabsScreenState createState() => _ManageTabsScreenState();
}

class _ManageTabsScreenState extends State<ManageTabsScreen> {
  // Dummy List: Backend se yahi list update hogi
  List<CategoryTab> allTabs = [
    CategoryTab(id: "1", title: "Emotions", titleUrdu: "احساسات"),
    CategoryTab(id: "2", title: "Food", titleUrdu: "کھانا"),
    CategoryTab(id: "3", title: "Action", titleUrdu: "کام"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Manage Tabs"), backgroundColor: Colors.orange.shade800),
      body: ListView.builder(
        itemCount: allTabs.length,
        itemBuilder: (context, index) {
          return SwitchListTile(
            title: Text(allTabs[index].title),
            subtitle: Text(allTabs[index].titleUrdu),
            value: allTabs[index].isEnabled,
            onChanged: (bool value) {
              setState(() {
                allTabs[index].isEnabled = value;
              });
            },
          );
        },
      ),
    );
  }
}