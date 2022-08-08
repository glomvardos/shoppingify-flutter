class Item {
  int? id;
  final DateTime? createdAt;
  final String name;
  final String note;
  final String imageUrl;
  final String category;
  int quantity = 1;

  Item({
    this.id,
    this.createdAt,
    required this.name,
    required this.note,
    required this.imageUrl,
    required this.category,
  });

  // add category to categories list

  Item.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"]),
        name = json["name"],
        note = json["note"],
        imageUrl = json["imageUrl"],
        category = json["category"];

  Item.fromShoppingListJson(Map<String, dynamic> json)
      : name = json["name"],
        createdAt = DateTime.parse(json["createdAt"]),
        note = json["note"],
        imageUrl = json["imageUrl"],
        category = json["category"],
        quantity = json["quantity"];

  Map<String, dynamic> toJson() => {
        "name": name,
        "note": note,
        "imageUrl": imageUrl,
        "category": category,
        "quantity": quantity,
        "createdAt": createdAt?.toIso8601String(),
      };

  @override
  String toString() {
    return 'Item{id: $id, createdAt: $createdAt, name: $name, note: $note, imageUrl: $imageUrl, category: $category, quantity: $quantity}';
  }
}
