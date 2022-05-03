import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/screens/item_screen.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.categoryName, required this.item})
      : super(key: key);

  final String categoryName;
  final List<Map<String, dynamic>> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(StringMethods.capitalizeString(categoryName),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          const SizedBox(height: 5),
          Wrap(
            children: item
                .map(
                  (value) => SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.50) - 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(ItemScreen.routeName, arguments: value);
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                        color: Colors.white,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                StringMethods.capitalizeString(value['name']),
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              IconButton(
                                onPressed: () {
                                  BlocProvider.of<ShoppingListBloc>(context)
                                      .add(AddItem(item: value));
                                },
                                constraints:
                                    const BoxConstraints(maxHeight: 36),
                                icon: const Icon(
                                  Icons.add,
                                  color: Color(0xFFC1C1C4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
