import 'package:flutter/material.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/shopping_list/widgets/shopping_list_items.dart';
import 'package:shoppingify/widgets/ui/buttons/go_back_btn.dart';
import 'package:shoppingify/widgets/ui/shopping_list_header.dart';

class SelectedShoppingListScreen extends StatelessWidget {
  const SelectedShoppingListScreen({Key? key}) : super(key: key);
  static const routeName = '/selected-shopping-list';

  @override
  Widget build(BuildContext context) {
    final shoppingList =
        ModalRoute.of(context)?.settings.arguments as ShoppingList;
    final Map<String, List<Item>> items = {};

    for (var item in shoppingList.categories) {
      if (!items.containsKey(item.category)) {
        items[item.category] = [item];
      } else {
        items[item.category]!.add(item);
      }
    }

    final List<Widget> displayItems = [];
    items.forEach((category, items) {
      displayItems.add(
        ShoppingListItems(
          categoryName: category,
          items: items,
          isListOfCheckBoxes: true,
          listId: shoppingList.id,
        ),
      );
    });

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFF0DE),
        child: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GoBackBtn(),
                    const ShoppingListHeader(),
                    const SizedBox(height: 20),
                    Text(shoppingList.name,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                    ...displayItems,
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}

// TODO:
// 2. Set Shopping List as Active (if not already)
// 3. Add Cancel and Complete buttons
// 4. Strike through completed items
