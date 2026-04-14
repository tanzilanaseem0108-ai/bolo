import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  // Voice selection ke liye variable [cite: 65]
  String selectedVoice = "Man";

  @override
  Widget build(BuildContext context) {
    // Urdu dynamic layout check [cite: 60]
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Text(
                isUrdu ? "آئیں بولو سیٹ اپ کریں" : "Let's set up BOLO for the Communicator",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Name Input Field [cite: 106]
              TextField(
                decoration: InputDecoration(
                  labelText: isUrdu ? "نام" : "Communicator's name",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 15),

              // Age Input Field [cite: 106]
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: isUrdu ? "عمر (1-100 سال)" : "Communicator's Age (1-100 years)",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 25),

              // Voice Selection (Man/Woman) [cite: 65, 107]
              Text(isUrdu ? "آپ کونسی آواز پسند کریں گے؟" : "Which voice would you prefer?"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio(
                    value: "Man",
                    groupValue: selectedVoice,
                    onChanged: (val) => setState(() => selectedVoice = val.toString()),
                  ),
                  Text(isUrdu ? "مرد" : "Man"),
                  SizedBox(width: 30),
                  Radio(
                    value: "Woman",
                    groupValue: selectedVoice,
                    onChanged: (val) => setState(() => selectedVoice = val.toString()),
                  ),
                  Text(isUrdu ? "عورت" : "Woman"),
                ],
              ),

              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                onPressed: () {
                  // BACKEND MENTION: Aapki partner yahan ye data Firebase/Database mein save karengi [cite: 61, 62]
                  print("Saving data...");
                },
                child: Text(isUrdu ? "آگے بڑھیں" : "Get Started"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}