import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/widgets/items/shopping_list_items.dart';
import 'package:shoppingify/widgets/ui/buttons/save_list_button.dart';
import 'package:shoppingify/widgets/ui/shopping_list_header.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);
  static const routeName = '/shopping-list';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFF0DE),
        child: SafeArea(
          child: BlocBuilder<ShoppingListBloc, ShoppingListState>(
            builder: (context, state) {
              if (state is ShoppingListLoaded) {
                final Map<String, List<Item>> transformedItems = {};
                for (var item in state.items) {
                  if (!transformedItems.containsKey(item.category)) {
                    transformedItems[item.category] = [item];
                  } else {
                    transformedItems[item.category]!.add(item);
                  }
                }

                final List<Widget> displayItems = [];

                transformedItems.forEach((category, items) {
                  displayItems.add(
                      ShoppingListItems(categoryName: category, items: items));
                });

                return state.items.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const ShoppingListHeader(),
                            Column(
                              children: [
                                const Text(
                                  "No items",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Go back'),
                                ),
                              ],
                            ),
                            SvgPicture.asset(
                              'assets/images/shopping_cart.svg',
                              height: 180,
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        constraints:
                                            const BoxConstraints(maxHeight: 36),
                                        padding: const EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                      ),
                                      const SizedBox(width: 5),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(
                                          'Go back',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const ShoppingListHeader(),
                                  const SizedBox(height: 30),
                                  const Text(
                                    'Shopping list',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Column(
                                    children: displayItems,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SaveListButton(),
                        ],
                      );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
