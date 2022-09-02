import 'package:flutter/material.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/history/widgets/display_shopping_list.dart';

class ShoppingLists extends StatelessWidget {
  const ShoppingLists({Key? key, required this.shoppingLists})
      : super(key: key);
  final List<ShoppingList> shoppingLists;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (shoppingLists.isEmpty)
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.65,
                child: const Center(
                    child: Text("You don't have any shopping lists"))),
          const SizedBox(height: 20),
          if (shoppingLists.isNotEmpty)
            Expanded(
              child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  itemCount: shoppingLists.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.only(right: 20),
                          color: Colors.red,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 35,
                          ),
                          alignment: Alignment.centerRight,
                        ),
                        key: Key(shoppingLists[index].id.toString()),
                        child: DisplayShoppingList(
                            shoppingList: shoppingLists[index]),
                      ),
                    );
                  }),
            ),
        ],
      ),
    );
  }
}
