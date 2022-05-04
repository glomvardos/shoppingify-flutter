import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/models/item.dart';
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

                print('test $transformedItems');

                return state.items.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ShoppingListHeader(),
                          Column(
                            children: [
                              const Text(
                                "No items",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
                      )
                    : Column(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const ShoppingListHeader(),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 30),
                                    width: 310,
                                    child: const Text(
                                      'Shopping list',
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
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
