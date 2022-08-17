import 'package:flutter/material.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/history/widgets/display_shopping_list.dart';

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
          if (shoppingLists.isEmpty)
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: const Center(
                    child: Text("You don't have any shopping lists"))),
          const SizedBox(height: 20),
          if (shoppingLists.isNotEmpty)
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: shoppingLists.length,
                itemBuilder: (context, index) {
                  return DisplayShoppingList(
                      shoppingList: shoppingLists[index]);
                }),
        ],
      ),
    );
  }
}
