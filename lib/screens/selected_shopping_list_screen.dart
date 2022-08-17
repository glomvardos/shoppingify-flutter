import 'package:flutter/material.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/widgets/ui/buttons/go_back_btn.dart';
import 'package:shoppingify/widgets/ui/shopping_list_header.dart';

class SelectedShoppingListScreen extends StatelessWidget {
  const SelectedShoppingListScreen({Key? key}) : super(key: key);
  static const routeName = '/selected-shopping-list';

  @override
  Widget build(BuildContext context) {
    final shoppingList =
        ModalRoute.of(context)?.settings.arguments as ShoppingList;

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
                  children: [const GoBackBtn(), const ShoppingListHeader()],
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
// 1. Display the selected shopping list
// 2. Set Shopping List as Active (if not already)
// 3. Add Cancel and Complete buttons
// 4. Strike through completed items
