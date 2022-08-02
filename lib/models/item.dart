class Item {
  final int? id;
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

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        createdAt: DateTime.parse(json["createdAt"]),
        name: json["name"],
        note: json["note"],
        imageUrl: json["imageUrl"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "note": note,
        "imageUrl": imageUrl,
        "category": category,
        "quantity": quantity,
      };

  @override
  String toString() {
    return 'Item{id: $id, createdAt: $createdAt, name: $name, note: $note, imageUrl: $imageUrl, category: $category, quantity: $quantity}';
  }
}
