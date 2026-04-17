import '../main.dart'; // Ye line BoloApp ki red line khatam kar degi
import 'setup_screen.dart';
import 'package:flutter/material.dart';


class LanguageSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo or Name
            Text(
              "BOLO",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 50),
            Text(
              "Select Language / زبان منتخب کریں",
              style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
            ),
            SizedBox(height: 30),

            // English Button
            _languageButton(context, "English", "🇺🇸", Locale('en', 'US')),

            SizedBox(height: 20),

            // Urdu Button
            _languageButton(context, "اردو", "🇵🇰", Locale('ur', 'PK')),
          ],
        ),
      ),
    );
  }

  Widget _languageButton(BuildContext context, String title, String flag, Locale locale) {
    return SizedBox(
      width: 280,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange.shade700,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        onPressed: () {
          // --- LANGUAGE CHANGE LOGIC ---
          // Ye line main.dart ke setLocale function ko call karegi
          BoloApp.setLocale(context, locale);

          // --- NAVIGATION ---
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SetupScreen()),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(flag, style: TextStyle(fontSize: 24)),
            SizedBox(width: 15),
            Text(title, style: TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}