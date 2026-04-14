import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/setup_screen.dart'; // Import naya screen
import 'widgets/language_card.dart'; // Import naya widget
import 'dart:async';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Full screen hide notification bar
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) => runApp(BoloApp()));
}

class BoloApp extends StatefulWidget {
  @override
  _BoloAppState createState() => _BoloAppState();
}

class _BoloAppState extends State<BoloApp> {
  Locale _currentLocale = Locale('en', 'US'); // Default English [cite: 1]

  void changeLanguage(Locale type) {
    setState(() {
      _currentLocale = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOLO',
      locale: _currentLocale, // Dynamic Language Control [cite: 1]
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ur', 'PK'),
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SplashScreen(onChangeLanguage: changeLanguage),
    );
  }
}

// --- 1. SPLASH SCREEN (3 Seconds) ---
class SplashScreen extends StatefulWidget {
  final Function(Locale) onChangeLanguage;
  SplashScreen({required this.onChangeLanguage});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LanguageSelectionScreen(onChangeLanguage: widget.onChangeLanguage),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade800,
      body: Center(
        child: Text(
          "BOLO",
          style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}

// --- 2. LANGUAGE SELECTION SCREEN ---
class LanguageSelectionScreen extends StatelessWidget {
  final Function(Locale) onChangeLanguage;
  LanguageSelectionScreen({required this.onChangeLanguage});

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isUrdu ? "زبان کا انتخاب کریں" : "Select Your Language",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.orange.shade800),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LanguageCard(
                  label: "English (US)",
                  flagEmoji: "🇺🇸",
                  onTap: () {
                    onChangeLanguage(Locale('en', 'US'));
                    _goToSetup(context);
                  },
                ),
                SizedBox(width: 30),
                LanguageCard(
                  label: "اردو (Urdu)",
                  flagEmoji: "🇵🇰",
                  onTap: () {
                    onChangeLanguage(Locale('ur', 'PK'));
                    _goToSetup(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _goToSetup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SetupScreen()), // Page 5 Setup Screen par le jayega [cite: 47]
    );
  }