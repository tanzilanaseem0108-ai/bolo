import 'package:flutter/material.dart';
import '../models/child_model.dart';
import 'add_child_screen.dart';
import 'chat_screen.dart';
import 'manage_tabs_screen.dart';
import 'language_settings_screen.dart';
import 'login_screen.dart';
import 'add_therapist_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _wordsController = TextEditingController();

  // --- BACKEND MENTION: Ye data backend se aayega aur save hoga ---
  List<Map<String, dynamic>> progressData = [];

  int columns = 5;
  int rows = 3;
  bool showKeyboard = false;

  // --- DUMMY DATA: Ye placeholders hain ---
  String parentName = "Sara Khan";

  // --- DUMMY DATA: List of children (Real app mein API se fetch hogi) ---
  List<ChildProfile> myChildren = [
    ChildProfile(id: "1", name: "Zain", age: "5", voice: "Male"),
    ChildProfile(id: "2", name: "Ayesha", age: "7", voice: "Female"),
  ];

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  Widget _buildBarButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black54)),
          ],
        ),
      ),
    );
  }

  Widget sideMenuButton(IconData icon, String label, Color color) {
    return Container(
      height: 50, width: double.infinity,
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
          _buildKeyboardRow(row1),
          _buildKeyboardRow(row2),
          _buildKeyboardRow(row3),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: _buildKey("SPACE", isLong: true, color: Colors.grey.shade300, icon: Icons.space_bar),
              ),
              SizedBox(width: 4),
              Expanded(
                flex: 1,
                child: _buildKey("DELETE", color: Colors.red.shade400, icon: Icons.backspace),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKeyboardRow(List<String> keys) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: keys.map((key) => Expanded(child: _buildKey(key))).toList(),
      ),
    );
  }

  Widget _buildKey(String label, {bool isLong = false, Color? color, IconData? icon}) {
    Color defaultColor = ["E", "U", "I", "A"].contains(label)
        ? Colors.teal.shade200
        : Colors.orange.shade100;

    return GestureDetector(
      onTap: () async {
        if (label == "SPACE") {
          await flutterTts.speak("Space");
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
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color ?? defaultColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 1, offset: Offset(0, 2))],
        ),
        child: Center(
          child: icon != null
              ? Icon(icon, size: 24)
              : Text(label, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Profile"),
        content: Text("Do you really want to delete ${myChildren[index].name} profile?"),
        actions: [
          TextButton(child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () {
              setState(() { myChildren.removeAt(index); });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = Localizations.localeOf(context).languageCode == 'ur';

    return Scaffold(
      backgroundColor: Color(0xFF4E342E),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.orange.shade900),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.orange.shade900)),
                    SizedBox(height: 10),
                    Text(
                      parentName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ExpansionTile(
              leading: Icon(Icons.settings, color: Colors.orange),
              title: Text(isUrdu ? "ترتیبات" : "Settings"),
              children: [
                ListTile(
                  leading: Icon(Icons.grid_view),
                  title: Text(isUrdu ? "گرڈ لے آؤٹ تبدیل کریں" : "Change Grid Layout"),
                  onTap: () => _showGridDialog(context),
                ),
                ListTile(
                  leading: Icon(Icons.category),
                  title: Text(isUrdu ? "ٹیبز شامل یا ختم کریں" : "Add/Remove Tabs & Items"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ManageTabsScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(isUrdu ? "زبان کی ترتیبات" : "Language Setting"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSettingsScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.child_care),
                  title: Text(isUrdu ? "بچہ شامل کریں" : "Add Child"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddChildScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.medical_services),
                  title: Text(isUrdu ? "تھراپسٹ شامل کریں" : "Add Therapist"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddTherapistScreen())),
                ),
              ],
            ),
            Divider(),
            // --- BACKEND MENTION: myChildren list will come from API ---
            ...myChildren.map((child) => ListTile(
              leading: CircleAvatar(backgroundColor: Colors.orange.shade100, child: Icon(Icons.face, color: Colors.orange.shade900)),
              title: Text(child.name),
              subtitle: Text("${isUrdu ? "عمر" : "Age"}: ${child.age}"),
              onTap: () => _showChildProgress(context, child),
              onLongPress: () => _confirmDelete(myChildren.indexOf(child)),
              trailing: Icon(Icons.analytics_outlined),
            )).toList(),
            Divider(),
            // --- DUMMY DATA: Therapist Name ---
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.teal, child: Icon(Icons.person, color: Colors.white)),
              title: Text("Dr. Sara Ahmed"),
              trailing: IconButton(icon: Icon(Icons.chat, color: Colors.teal), onPressed: () => _openChat(context, "Dr. Sara")),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text(isUrdu ? "سائن آؤٹ" : "Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false),
            ),
          ],
        ),
      ),
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 80, width: double.infinity, margin: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _wordsController,
                          textAlign: TextAlign.center,
                          readOnly: true,
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.brown),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: isUrdu ? "بولیں..." : "Speak...",
                          ),
                        ),
                      ),
                      _buildBarButton(Icons.volume_up, isUrdu ? "بولیں" : "Speak", Colors.blue, () {
                        if (_wordsController.text.isNotEmpty) {
                          _speak(_wordsController.text);
                        }
                      }),
                      _buildBarButton(Icons.delete_sweep, isUrdu ? "صاف" : "Clear", Colors.red, () {
                        setState(() { _wordsController.clear(); });
                      }),
                      // --- BACKEND MENTION: Submit button will trigger an API POST to save progress ---
                      _buildBarButton(Icons.send, isUrdu ? "جمع" : "Submit", Colors.green, () {
                        if (_wordsController.text.isNotEmpty) {
                          setState(() {
                            progressData.add({
                              'text': _wordsController.text,
                              'time': DateTime.now(),
                            });
                            _wordsController.clear();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(isUrdu ? "محفوظ کر لیا گیا!" : "Progress Saved!")),
                          );
                        }
                      }),
                    ],
                  ),
                ),
                Expanded(
                  child: showKeyboard
                      ? _buildCustomKeyboard()
                      : GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 1.4,
                    ),
                    itemCount: rows * columns,
                    // --- BACKEND MENTION: "Word" text will be replaced by API categories (Food, etc.) ---
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
                      child: Center(child: Text("Word")),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) => Container(
              width: 90, color: Color(0xFF3E2723),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: sideMenuButton(Icons.menu, isUrdu ? "مینو" : "Menu", Colors.orange.shade900),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showKeyboard = !showKeyboard;
                      });
                    },
                    child: sideMenuButton(
                        showKeyboard ? Icons.image : Icons.keyboard,
                        showKeyboard
                            ? (isUrdu ? "تصویریں" : "Pictures")
                            : (isUrdu ? "کی بورڈ" : "Keyboard"),
                        Colors.brown.shade400
                    ),
                  ),
                  sideMenuButton(Icons.arrow_back, isUrdu ? "واپس" : "Go back", Colors.brown.shade400),
                  sideMenuButton(Icons.home, isUrdu ? "ہوم" : "Home", Colors.brown.shade400),
                  sideMenuButton(Icons.search, isUrdu ? "تلاش" : "Search", Colors.brown.shade400),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openChat(BuildContext context, String name) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen(therapistName: name)));
  }

  void _showChildProgress(BuildContext context, ChildProfile child) {
    // --- BACKEND MENTION: progressData will be used here to generate a Real Bar Graph ---
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        height: 300,
        child: Column(
          children: [
            Text("${child.name}'s Progress", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Expanded(child: Center(child: Text("Bar Graph will be here"))),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Close"))
          ],
        ),
      ),
    );
  }

  void _showGridDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Grid Size"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(title: Text("3x3"), onTap: () { setState(() { columns = 3; rows = 3; }); Navigator.pop(context); }),
            ListTile(title: Text("3x5"), onTap: () { setState(() { columns = 5; rows = 3; }); Navigator.pop(context); }),
            ListTile(title: Text("8x5"), onTap: () { setState(() { columns = 8; rows = 5; }); Navigator.pop(context); }),
          ],
        ),
      ),
    );
  }
}