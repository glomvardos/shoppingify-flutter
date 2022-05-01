import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';

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
                print(state.items);
                return state.items.isEmpty
                    ? Text(
                        "You haven't added any items to your shopping list yet")
                    : Text('Loaded');
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
