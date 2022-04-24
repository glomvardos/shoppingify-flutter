import 'dart:convert';

// Item itemFromJson(String str) => Item.fromJson(json.decode(str));
//
// String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  int? id;
  DateTime? createdAt;
  String name;
  String note;
  String imageUrl;
  String category;

  Item({
    this.id,
    this.createdAt,
    required this.name,
    required this.note,
    required this.imageUrl,
    required this.category,
  });

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
      };
}
