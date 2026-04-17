class CategoryTab {
  final String id;
  final String title;
  final String titleUrdu;
  bool isEnabled; // Ye define karega ke tab screen par nazar aaye ya nahi

  CategoryTab({
    required this.id,
    required this.title,
    required this.titleUrdu,
    this.isEnabled = true
  });
}