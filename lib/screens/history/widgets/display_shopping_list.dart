import 'package:flutter/material.dart';
import 'package:shoppingify/helpers/shopping_list_status.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:intl/intl.dart';
import 'package:shoppingify/screens/selected_shopping_list/selected_shopping_list_screen.dart';

class DisplayShoppingList extends StatelessWidget {
  const DisplayShoppingList({
    Key? key,
    required this.shoppingList,
  }) : super(key: key);
  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: InkWell(
          splashColor: Theme.of(context).colorScheme.primary,
          onTap: () {
            Navigator.of(context).pushNamed(
                SelectedShoppingListScreen.routeName,
                arguments: shoppingList);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      shoppingList.name,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.event_note,
                          size: 24,
                          color: Color(0xFFC1C1C4),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          DateFormat('E dd.MM.yyyy')
                              .format(shoppingList.createdAt!),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: ShoppingListStatus.status(
                                  shoppingList)['color'],
                              width: 1,
                            ),
                          ),
                          child: Text(
                            ShoppingListStatus.status(shoppingList)['status'],
                            style: TextStyle(
                              color: ShoppingListStatus.status(
                                  shoppingList)['color'],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 28,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
