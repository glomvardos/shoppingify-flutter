import 'package:flutter/material.dart';
import 'package:shoppingify/models/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.items}) : super(key: key);

  final List<Item> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: items.length,
        itemBuilder: (_, index) {
          return Container(
            child: Text('test'),
          );
        });
  }
}
