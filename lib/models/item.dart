class Item {
  int? id;
  DateTime? createdAt;
  String? note;
  String? imageUrl;
  int quantity = 1;
  bool isChecked = false;
  final String name;
  final String category;

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

  Map<String, dynamic> toJson() => {
        "name": name,
        "note": note,
        "imageUrl": imageUrl,
        "category": category,
        "quantity": quantity,
        "isChecked": isChecked,
      };

  Item.shoppingListItemfromJson(Map<String, dynamic> json)
      : id = json["id"],
        createdAt = DateTime.parse(json["createdAt"]),
        name = json["name"],
        category = json["category"],
        quantity = json["quantity"],
        isChecked = json["isChecked"];

  Map<String, dynamic> shoppingListItemToJson() => {
        "name": name,
        "category": category,
        "quantity": quantity,
        "isChecked": isChecked,
      };

  @override
  String toString() {
    return 'Item{id: $id, createdAt: $createdAt, name: $name, note: $note, imageUrl: $imageUrl, category: $category, quantity: $quantity, isChecked: $isChecked}';
  }
}
