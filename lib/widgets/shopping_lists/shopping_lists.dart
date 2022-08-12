import 'package:flutter/material.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/widgets/shopping_lists/display_shopping_list.dart';

class ShoppingLists extends StatelessWidget {
  const ShoppingLists({Key? key, required this.shoppingLists})
      : super(key: key);
  final List<ShoppingList> shoppingLists;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Shopping History',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: shoppingLists.isEmpty
                ? const Center(child: Text("You don't have any shopping lists"))
                : ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: shoppingLists.length,
                    itemBuilder: (context, index) {
                      return DisplayShoppingList(
                          shoppingList: shoppingLists[index]);
                    }),
          ),
        ],
      ),
    );
  }
}
