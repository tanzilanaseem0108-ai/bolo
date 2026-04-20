import 'package:flutter/material.dart';
import '../main.dart'; // Is se BoloApp ki red line khatam hogi

class LanguageSettingsScreen extends StatefulWidget {
  @override
  _LanguageSettingsScreenState createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    // Current language status check karne ke liye
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(isUrdu ? "زبان کی ترتیبات" : "Language Settings"),
        backgroundColor: Colors.orange.shade900,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // ENGLISH OPTION
            ListTile(
              leading: Text("🇺🇸", style: TextStyle(fontSize: 24)),
              title: Text("English (US)"),
              trailing: !isUrdu ? Icon(Icons.check_circle, color: Colors.green) : null,
              onTap: () {
                // Ye line puri app ko refresh karegi
                BoloApp.setLocale(context, Locale('en', 'US'));
                setState(() {}); // Screen ko update karne ke liye
              },
            ),
            Divider(),

            // URDU OPTION
            ListTile(
              leading: Text("🇵🇰", style: TextStyle(fontSize: 24)),
              title: Text("اردو (پاکستان)"),
              trailing: isUrdu ? Icon(Icons.check_circle, color: Colors.green) : null,
              onTap: () {
                // Ye line puri app ko refresh karegi
                BoloApp.setLocale(context, Locale('ur', 'PK'));
                setState(() {}); // Screen ko update karne ke liye
              },
            ),
          ],
        ),
      ),
    );
  }
}