import 'package:flutter/material.dart';

class TherapistDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Urdu support check
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      appBar: AppBar(
        title: Text(isUrdu ? "تھراپسٹ ڈیش بورڈ" : "Therapist Dashboard"),
        backgroundColor: Colors.teal.shade700, // Therapist ke liye different color
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Wapis login par jane ke liye
              Navigator.pushReplacementNamed(context, '/login');
            },
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal.shade700),
              child: Center(
                child: Text(
                  isUrdu ? "تھراپسٹ مینو" : "Therapist Menu",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text(isUrdu ? "میرے مریض" : "My Patients / Children"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text(isUrdu ? "چیٹ" : "Messages"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(isUrdu ? "ترتیبات" : "Settings"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              isUrdu ? "درخواستیں" : "Pending Requests",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // Example of a Parent Request Card
            Card(
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.person, color: Colors.white)),
                title: Text("Parent: Ahmed Khan"),
                subtitle: Text("Child: Zain | Age: 6"),
                trailing: Wrap(
                  spacing: 12,
                  children: [
                    IconButton(icon: Icon(Icons.check_circle, color: Colors.green), onPressed: () {}),
                    IconButton(icon: Icon(Icons.cancel, color: Colors.red), onPressed: () {}),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}