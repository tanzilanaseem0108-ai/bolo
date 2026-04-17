import 'package:flutter/material.dart';

class LanguageSettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Language Settings"), backgroundColor: Colors.orange.shade800),
      body: Column(
        children: [
          ListTile(
            leading: Icon(Icons.language),
            title: Text("English (US)"),
            trailing: Icon(Icons.check_circle, color: Colors.green),
            onTap: () { /* Language change logic */ },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("Urdu (اردو)"),
            onTap: () { /* Language change logic */ },
          ),
        ],
      ),
    );
  }
}