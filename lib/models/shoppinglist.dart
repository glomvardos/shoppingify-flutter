import 'package:shoppingify/models/item.dart';

class ShoppingList {
  final int? id;
  final DateTime? createdAt;
  final String updatedAt;
  final String name;
  final List<Item> categories;
  final bool isCompleted;
  final bool isCancelled;
  final bool isActive;

  ShoppingList({
    this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.categories,
    required this.isCompleted,
    required this.isCancelled,
    required this.isActive,
  });

  ShoppingList.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        createdAt = DateTime.parse(json["createdAt"]),
        updatedAt = json['updatedAt'],
        name = json['name'],
        categories = (json['categories'] as List)
            .map((item) => Item.shoppingListItemfromJson(item))
            .toList(),
        isCompleted = json['isCompleted'],
        isCancelled = json['isCancelled'],
        isActive = json['isActive'];

  @override
  String toString() {
    return 'ShoppingList{id: $id, createdAt: $createdAt, updatedAt: $updatedAt, name: $name, categories: $categories, isCompleted: $isCompleted, isCancelled: $isCancelled, isActive: $isActive}';
  }
}
