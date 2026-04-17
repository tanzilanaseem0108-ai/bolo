import 'package:flutter/material.dart';

class AddTherapistScreen extends StatefulWidget {
  @override
  _AddTherapistScreenState createState() => _AddTherapistScreenState();
}

class _AddTherapistScreenState extends State<AddTherapistScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _showResult = false;

  // Dummy data jo backend se search ho kar aayega
  String therapistName = "Dr. Sara Ahmed";
  String therapistSpecialty = "Speech Therapist";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Therapist"),
        backgroundColor: Colors.teal.shade700,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Input
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Enter Therapist Email or ID",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _showResult = true; // Search button dabane par result show hoga
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 30),

            // Search Result Card
            if (_showResult)
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.teal.shade100,
                        child: Icon(Icons.person, size: 40, color: Colors.teal),
                      ),
                      SizedBox(height: 10),
                      Text(therapistName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(therapistSpecialty, style: TextStyle(color: Colors.grey)),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: () {
                          // Backend API call: Send Request
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Request sent to $therapistName"))
                          );
                        },
                        child: Text("SEND CONNECTION REQUEST", style: TextStyle(color: Colors.white)),
                      ),
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