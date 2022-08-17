import 'package:flutter/material.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/screens/shopping_list/widgets/shopping_list_item.dart';

class ShoppingListItems extends StatelessWidget {
  const ShoppingListItems({
    Key? key,
    required this.categoryName,
    required this.items,
  }) : super(key: key);

  final String categoryName;
  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Text(
          StringMethods.capitalizeString(categoryName),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Color(0xFF828282),
          ),
        ),
        const SizedBox(height: 10),
        ...items
            .map(
              (item) => ShoppingListItem(item: item),
            )
            .toList()
      ],
    ));
  }
}
