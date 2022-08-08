import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';

class SaveListButton extends StatelessWidget {
  SaveListButton({Key? key, required this.items}) : super(key: key);
  final List<Item> items;
  final TextEditingController _listName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future<void> onSubmitShoppingList() async {
      if (_listName.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text('Please enter a name for the list'),
          ),
        );
        return;
      }

      await context
          .read<ShoppingListService>()
          .addNewList(items, _listName.text)
          .then((value) => {
                context.read<ShoppingListBloc>().add(InitialItems()),
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Your Shopping List has been saved!'),
                  ),
                )
              })
          .catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content:
              Text(error.response?.data['message'] ?? 'Something went wrong'),
        ));
      });
    }

    return Container(
      color: Colors.white,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            width: 310,
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _listName,
                    decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      errorStyle: TextStyle(fontSize: 12),
                      errorMaxLines: 1,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      labelText: 'Enter a name',
                      alignLabelWithHint: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),

                    // border: InputBorder.none,
                    // ),
                  ),
                ),
                ElevatedButton(
                    onPressed: onSubmitShoppingList,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                      ),
                      elevation: MaterialStateProperty.all<double>(0),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
