class Item {
  int? id;
  DateTime? createdAt;
  String name;
  String note;
  String imageUrl;
  String category;
  Map<String, Map<String, dynamic>> keyCategory;

  Item({
    this.id,
    this.createdAt,
    this.keyCategory = const {},
    required this.name,
    required this.note,
    required this.imageUrl,
    required this.category,
  });

  // add category to categories list
  static Map<String, Map<String, dynamic>> addCategory(
      Map<String, dynamic> json) {
    Map<String, Map<String, dynamic>> newCategory = {};
    String category = json['category'];

    newCategory[category] = json;

    return newCategory;
  }

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        note: json["note"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        keyCategory: addCategory(json),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "note": note,
        "imageUrl": imageUrl,
        "category": category,
      };
}
