import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/history/widgets/shopping_lists.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      builder: (context, state) {
        if (state is ShoppingListLoaded) {
          final shoppingLists = state.shoppingLists;
          final List<ShoppingList> shoppingListsResults = shoppingLists
              .where((list) =>
                  list.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ShoppingLists(shoppingLists: shoppingListsResults);
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<ShoppingListBloc, ShoppingListState>(
      builder: (context, state) {
        if (state is ShoppingListLoaded) {
          final shoppingLists = state.shoppingLists;
          final List<ShoppingList> shoppingListsResults = shoppingLists
              .where((list) =>
                  list.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
          return ShoppingLists(shoppingLists: shoppingListsResults);
        }
        return const SizedBox.shrink();
      },
    );
  }
}
