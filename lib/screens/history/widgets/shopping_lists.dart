import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/history/widgets/display_shopping_list.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';

class ShoppingLists extends StatelessWidget {
  const ShoppingLists({Key? key, required this.shoppingLists})
      : super(key: key);
  final List<ShoppingList> shoppingLists;
  @override
  Widget build(BuildContext context) {
    Future<bool> onConfirmDelete(ShoppingList shoppingList) async {
      return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Delete ${shoppingList.name} shopping list'),
          content:
              const Text('Are you sure you want to delete this shopping list?'),
          actions: [
            ElevatedButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      );
    }

    void onDeleteShoppingList(int id) async {
      await context
          .read<ShoppingListService>()
          .deleteShoppingList(id)
          .catchError(
        (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                  error.response!.data['message'] ?? 'Something went wrong'),
            ),
          );
        },
      );
    }

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
                        confirmDismiss: (_) =>
                            onConfirmDelete(shoppingLists[index]),
                        onDismissed: (_) =>
                            onDeleteShoppingList(shoppingLists[index].id!),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          padding: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.red,
                          ),
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
