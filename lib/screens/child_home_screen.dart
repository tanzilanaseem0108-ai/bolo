import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ChildHomeScreen extends StatefulWidget {
  @override
  _ChildHomeScreenState createState() => _ChildHomeScreenState();
}

class _ChildHomeScreenState extends State<ChildHomeScreen> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _wordsController = TextEditingController();

  bool showKeyboard = false;

  // --- BACKEND MENTION: Ye values bache ki settings ke mutabiq API se fetch hongi ---
  int columns = 5;
  int rows = 3;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage("en-US");
    // --- BACKEND MENTION: Voice settings (Pitch/Rate) profile se ayengi ---
    await flutterTts.setPitch(1.0);
  }

  // --- CUSTOM KEYBOARD LOGIC ---
  Widget _buildCustomKeyboard() {
    List<String> row1 = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"];
    List<String> row2 = ["A", "S", "D", "F", "G", "H", "J", "K", "L"];
    List<String> row3 = ["Z", "X", "C", "V", "B", "N", "M", ",", "."];

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(color: Color(0xFF3E2723)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildRow(row1),
          _buildRow(row2),
          _buildRow(row3),
          Row(
            children: [
              Expanded(flex: 5, child: _buildKey("SPACE", color: Colors.grey.shade300, icon: Icons.space_bar)),
              SizedBox(width: 4),
              Expanded(flex: 1, child: _buildKey("DELETE", color: Colors.red.shade400, icon: Icons.backspace)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> keys) => Row(children: keys.map((k) => Expanded(child: _buildKey(k))).toList());

  Widget _buildKey(String label, {Color? color, IconData? icon}) {
    return GestureDetector(
      onTap: () async {
        if (label == "SPACE") {
          setState(() => _wordsController.text += " ");
        } else if (label == "DELETE") {
          if (_wordsController.text.isNotEmpty) {
            setState(() => _wordsController.text = _wordsController.text.substring(0, _wordsController.text.length - 1));
          }
        } else {
          await flutterTts.stop();
          await flutterTts.speak(label);
          setState(() => _wordsController.text += label);
        }
      },
      child: Container(
        height: 55, margin: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: color ?? (["E","U","I","A"].contains(label) ? Colors.teal.shade200 : Colors.orange.shade100),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Center(child: icon != null ? Icon(icon) : Text(label, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4E342E),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                // Display Bar (Top)
                Container(
                  height: 80, margin: EdgeInsets.all(10), padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _wordsController,
                          readOnly: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
                          decoration: InputDecoration(border: InputBorder.none, hintText: "Type..."),
                        ),
                      ),
                      _barBtn(Icons.volume_up, "Speak", Colors.blue, () => flutterTts.speak(_wordsController.text)),
                      _barBtn(Icons.delete_sweep, "Clear", Colors.red, () => setState(() => _wordsController.clear())),

                      // --- BACKEND MENTION: Yahan se bache ki progress DB mein save hogi ---
                      _barBtn(Icons.send, "Submit", Colors.green, () {
                        if(_wordsController.text.isNotEmpty) {
                          _wordsController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved to Progress!")));
                        }
                      }),
                    ],
                  ),
                ),

                // Main Content (Keyboard or Pictures)
                Expanded(
                  child: showKeyboard
                      ? _buildCustomKeyboard()
                      : GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns, childAspectRatio: 1.4, crossAxisSpacing: 5, mainAxisSpacing: 5
                    ),
                    itemCount: rows * columns,
                    // --- BACKEND MENTION: Yahan asli images aur words ayenge ---
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Icon(Icons.image, color: Colors.grey.shade300, size: 40)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Side Bar (Navigation)
          Container(
            width: 90, color: Color(0xFF3E2723),
            child: Column(
              children: [
                SizedBox(height: 60),
                _sideBtn(showKeyboard ? Icons.image : Icons.keyboard, showKeyboard ? "Pictures" : "Keyboard", () {
                  setState(() => showKeyboard = !showKeyboard);
                }),
                _sideBtn(Icons.arrow_back, "Go Back", () {
                  // Navigation logic for going back
                }),
                _sideBtn(Icons.home, "Home", () {
                  // Reset to home state
                }),
                Spacer(),
                // Extra safety ke liye chota exit button (Optionally added)
                IconButton(icon: Icon(Icons.exit_to_app, color: Colors.brown.shade700, size: 20), onPressed: () => Navigator.pop(context)),
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _barBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: color), Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold))]),
      ),
    );
  }

  Widget _sideBtn(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60, width: double.infinity, margin: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        decoration: BoxDecoration(color: Colors.brown.shade400, borderRadius: BorderRadius.circular(8)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: Colors.white, size: 20), Text(label, style: TextStyle(color: Colors.white, fontSize: 10))]),
      ),
    );
  }
}