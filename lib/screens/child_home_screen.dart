import 'package:flutter/material.dart';

class ChildHomeScreen extends StatefulWidget {
  @override
  _ChildHomeScreenState createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  // Bache ke liye default grid 3x5
  int columns = 5;
  int rows = 3;

  Widget sideMenuButton(IconData icon, String label, Color color) {
    return Container(
      height: 50,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          Text(label, style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4E342E),
      body: Row(
        children: [
          // Grid Area
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("Words will appear here...")),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: rows * columns,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("Word")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Fixed Sidebar (No Menu Button)
          Container(
            width: 90,
            color: Color(0xFF3E2723),
            child: Column(
              children: [
                // Yahan Menu button nahi hai taake bacha settings na khol sakay
                sideMenuButton(Icons.keyboard, "Keyboard", Colors.brown.shade400),
                sideMenuButton(Icons.arrow_back, "Go back", Colors.brown.shade400),
                sideMenuButton(Icons.home, "Home", Colors.brown.shade400),
                sideMenuButton(Icons.favorite, "Favorite", Colors.brown.shade400),
                sideMenuButton(Icons.search, "Search", Colors.brown.shade400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}