import 'package:flutter/material.dart';
import '../models/child_model.dart';
import 'add_child_screen.dart';
import 'chat_screen.dart';
import 'manage_tabs_screen.dart';
import 'language_settings_screen.dart';
import 'login_screen.dart';
import 'add_therapist_screen.dart';

class ParentDashboard extends StatefulWidget {
  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  int columns = 5;
  int rows = 3;

  // Dynamic list of children
  List<ChildProfile> myChildren = [
    ChildProfile(id: "1", name: "Zain", age: "5", voice: "Male"),
    ChildProfile(id: "2", name: "Ayesha", age: "7", voice: "Female"),
  ];

  // Sidebar Button Widget
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

  // Delete Confirmation Dialog
  void _confirmDelete(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete Profile"),
        content: Text("Kya aap waqai ${myChildren[index].name} ki profile delete karna chahte hain? Is se database se bhi sara data khatam ho jayega."),
        actions: [
          TextButton(child: Text("Cancel"), onPressed: () => Navigator.pop(context)),
          TextButton(
            child: Text("Delete", style: TextStyle(color: Colors.red)),
            onPressed: () {
              setState(() {
                // Yahan Backend API call hogi database se delete karne ke liye
                print("Deleting ID: ${myChildren[index].id} from Database");
                myChildren.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Profile Deleted Successfully")));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4E342E),
      // --- SIDE MENU (DRAWER) ---
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.orange.shade900),
              child: Text("BOLO Parent Menu", style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            // Settings Group
            ExpansionTile(
              leading: Icon(Icons.settings, color: Colors.orange),
              title: Text("Settings"),
              children: [
                ListTile(
                  leading: Icon(Icons.grid_view),
                  title: Text("Change Grid Layout"),
                  onTap: () => _showGridDialog(context),
                ),
                ListTile(
                  leading: Icon(Icons.tab_unselected),
                  title: Text("Add/Remove Tab"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ManageTabsScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text("Language Setting"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSettingsScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.child_care),
                  title: Text("Add Child"),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddChildScreen())),
                ),
                ListTile(
                  leading: Icon(Icons.medical_services),
                  title: Text("Add Therapist"),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddTherapistScreen())
                    );
                  },
                ),
              ],
            ),
            Divider(),

            // --- PROFILES & CHAT SECTION ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("Profiles & Messages", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
            ),

// Dynamic Children List (Puraana wala logic)
            ...myChildren.map((child) => ListTile(
              leading: Icon(Icons.person, color: Colors.orange),
              title: Text("Child: ${child.name}"),
              onLongPress: () => _confirmDelete(myChildren.indexOf(child)),
            )).toList(),

            Divider(),

// THERAPIST CHAT (Ye ab enable hai)
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.teal,
                child: Icon(Icons.medical_services, color: Colors.white, size: 20),
              ),
              title: Text("Therapist: Dr. Sara"),
              subtitle: Text("Online"),
              // Yahan se Chat Screen khulegi
              trailing: IconButton(
                icon: Icon(Icons.chat, color: Colors.teal),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChatScreen(therapistName: "Dr. Sara")),
                  );
                },
              ),
            ),
            ...List.generate(myChildren.length, (index) {
              final child = myChildren[index];
              return ListTile(
                leading: CircleAvatar(backgroundColor: Colors.orange.shade100, child: Icon(Icons.person, color: Colors.brown)),
                title: Text(child.name),
                subtitle: Text("Age: ${child.age}"),
                onLongPress: () => _confirmDelete(index), // Long press to delete logic
                onTap: () {},
              );
            }),

            Divider(),
            // Sign Out Option
            ListTile(
              leading: Icon(Icons.logout, color: Colors.red),
              title: Text("Sign Out", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                );
              },
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
                  height: 60, width: double.infinity, margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Text("Words Display")),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(5),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columns, crossAxisSpacing: 5, mainAxisSpacing: 5, childAspectRatio: 1.4,
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
          // RIGHT SIDEBAR (With Menu Trigger)
          Builder(
            builder: (context) => Container(
              width: 90, color: Color(0xFF3E2723),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: sideMenuButton(Icons.menu, "Menu", Colors.orange.shade900),
                  ),
                  sideMenuButton(Icons.keyboard, "Keyboard", Colors.brown.shade400),
                  sideMenuButton(Icons.arrow_back, "Go back", Colors.brown.shade400),
                  sideMenuButton(Icons.home, "Home", Colors.brown.shade400),
                  sideMenuButton(Icons.search, "Search", Colors.brown.shade400),
                ],
              ),
            ),
          ),
        ],
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