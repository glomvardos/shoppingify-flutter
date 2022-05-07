import 'package:flutter/material.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/item.dart';

class ShoppingListItems extends StatelessWidget {
  const ShoppingListItems({
    Key? key,
    required this.categoryName,
    required this.items,
  }) : super(key: key);

  final String categoryName;
  final List<Item> items;

  ListTile _buildItem(BuildContext context, Item item) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Text(
        StringMethods.capitalizeString(item.name),
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFFFFF0DE),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: () {},
        child: Text(
          '${item.quantity.toString()} pcs',
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

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
        ...items.map((item) => _buildItem(context, item)).toList()
      ],
    ));
  }
}
