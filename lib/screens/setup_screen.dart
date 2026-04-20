import 'login_screen.dart';
import 'package:flutter/material.dart';

class SetupScreen extends StatefulWidget {
  @override
  _SetupScreenState createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  String selectedVoice = "Man";

  // --- 1. Controllers aur Form Key (Validation ke liye) ---
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode ageFocus = FocusNode();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    nameFocus.dispose();
    ageFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      // --- ADDED THIS LINE TO FIX OVERFLOW ---
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          // --- 2. Poore Column ko Form mein wrap kiya ---
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 02),
                Text(
                  isUrdu ? "آئیں بولو سیٹ اپ کریں" : "Let's set up BOLO for the Communicator",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),

                // Name Input Field (With Validation)
                TextFormField(
                  controller: nameController,
                  focusNode: nameFocus,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: isUrdu ? "نام" : "Communicator's name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  // Check agar khali hai
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return isUrdu ? "براہ کرم نام درج کریں" : "Please enter a name";
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(ageFocus);
                  },
                ),
                SizedBox(height: 15),

                // Age Input Field (With Validation)
                TextFormField(
                  controller: ageController,
                  focusNode: ageFocus,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: isUrdu ? "عمر (1-100 سال)" : "Communicator's Age (1-100 years)",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.cake),
                  ),
                  // Check agar khali hai ya number nahi hai
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return isUrdu ? "براہ کرم عمر درج کریں" : "Please enter age";
                    }
                    if (int.tryParse(value) == null) {
                      return isUrdu ? "صرف نمبر لکھیں" : "Please enter numbers only";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Voice Selection
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

                SizedBox(height: 15),

                // Get Started Button
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () {
                      // --- 3. Validation Check: Jab tak dono fill na hon, agay nahi jayega ---
                      if (_formKey.currentState!.validate()) {
                        print("Saving Name: ${nameController.text}");
                        print("Saving Age: ${ageController.text}");
                        print("Voice: $selectedVoice");

                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      }
                    },
                    child: Text(
                      isUrdu ? "آگے بڑھیں" : "Get Started",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}