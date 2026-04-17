import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> selectedWords = [];

  // Grid Settings: In variables ko change karne se grid change ho jayegi
  int columns = 5; // Default columns
  int totalItems = 15; // Default (3x5)

  // Backend Tracking Logic
  void _submitToBackend() {
    print("Sending data to backend: $selectedWords");
    setState(() {
      selectedWords.clear();
    });
  }

  // Sidebar Button Helper
  Widget _sideMenuButton(IconData icon, String label, Color color) {
    return Expanded(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: InkWell(
          onTap: () {
            // Button Actions yahan aayenge
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 24),
              SizedBox(height: 4),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Color(0xFF4E342E), // Brown Background (As per screenshot)
      body: Row(
        children: [
          // --- LEFT SIDE: SENTENCE BAR & GRID (85% Width) ---
          Expanded(
            flex: 8,
            child: Column(
              children: [
                // Top Bar / Sentence Builder
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            selectedWords.join(" "),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                      _topBarButton(isUrdu ? "بولیں" : "SPEAK", Colors.green, () {
                        // TTS Logic
                      }),
                      _topBarButton(isUrdu ? "صاف" : "CLEAR", Colors.red, () {
                        setState(() => selectedWords.clear());
                      }),
                    ],
                  ),
                ),

                // Dynamic Grid
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns, // Dynamic Columns
                      childAspectRatio: 1.1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: totalItems, // Dynamic Items
                    itemBuilder: (context, index) {
                      return _buildGridTile(index, isUrdu);
                    },
                  ),
                ),
              ],
            ),
          ),

          // --- RIGHT SIDE: SIDEBAR MENU (15% Width) ---
          Container(
            width: 110,
            padding: EdgeInsets.symmetric(vertical: 5),
            color: Color(0xFF3E2723), // Darker Brown Sidebar
            child: Column(
              children: [
                _sideMenuButton(Icons.keyboard, isUrdu ? "کی بورڈ" : "Keyboard", Colors.brown.shade700),
                _sideMenuButton(Icons.arrow_back, isUrdu ? "واپس" : "Go back", Colors.brown.shade400),
                _sideMenuButton(Icons.home, isUrdu ? "ہوم" : "Home", Colors.brown.shade400),
                _sideMenuButton(Icons.favorite, isUrdu ? "پسندیدہ" : "Favorite", Colors.pink.shade300),
                _sideMenuButton(Icons.apps, isUrdu ? "الفاظ" : "Core words", Colors.brown.shade400),
                _sideMenuButton(Icons.arrow_upward, isUrdu ? "پیچھے" : "Previous", Colors.brown.shade400),
                _sideMenuButton(Icons.arrow_downward, isUrdu ? "آگے" : "Next", Colors.brown.shade400),
                _sideMenuButton(Icons.search, isUrdu ? "تلاش" : "Search", Colors.brown.shade400),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Top Buttons
  Widget _topBarButton(String label, Color color, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color, elevation: 2),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
      ),
    );
  }

  // Grid Tile Design
  Widget _buildGridTile(int index, bool isUrdu) {
    // Labels List (Aap ise expand kar sakti hain)
    List<String> labels = ["Food", "Water", "Play", "Sleep", "Home", "Mom", "Dad", "Toilet", "Happy", "Sad", "Big", "Small", "Yes", "No", "Help"];
    List<String> labelsUrdu = ["کھانا", "پانی", "کھیلنا", "سونا", "گھر", "امی", "ابو", "واش روم", "خوش", "اداس", "بڑا", "چھوٹا", "جی ہاں", "نہیں", "مدد"];

    // Safety check taake index out of bounds na ho
    String text = (index < labels.length) ? (isUrdu ? labelsUrdu[index] : labels[index]) : "Word";

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedWords.add(text);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 2, offset: Offset(0, 2))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 35, color: Colors.grey.shade400),
            SizedBox(height: 4),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }
}