import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'screens/language_selection_screen.dart';
import 'package:flutter/material.dart';
import 'screens/parent_dashboard.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //notification bar hide
 SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      // Landscape mode lock
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).
  then((_) {
    runApp(BoloApp());
  });
}

class BoloApp extends StatefulWidget {
  // Static method taake hum kisi bhi screen se language change kar sakein
  static void setLocale(BuildContext context, Locale newLocale) {
    _BoloAppState? state = context.findAncestorStateOfType<_BoloAppState>();
    state?.changeLanguage(newLocale);
  }

  @override
  _BoloAppState createState() => _BoloAppState();
}

class _BoloAppState extends State<BoloApp> {
  Locale _locale = Locale('en', 'US'); // Default language

  void changeLanguage(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bolo App',
      theme: ThemeData(primarySwatch: Colors.orange),
      locale: _locale, // Ye line language control karti hai
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ur', 'PK'),
      ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // 3 seconds ka timer for Splash Screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LanguageSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "BOLO",
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
                letterSpacing: 5,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(color: Colors.orange),
          ],
        ),
      ),
    );
  }
}