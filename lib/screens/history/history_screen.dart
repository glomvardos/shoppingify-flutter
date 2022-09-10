import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';
import 'package:shoppingify/screens/history/widgets/shopping_lists.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  static const routeName = '/history';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.read<ShoppingListService>().getShoppingLists(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final shoppingLists = snapshot.data as List<ShoppingList>;
            shoppingLists.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
            context
                .read<ShoppingListBloc>()
                .add(AddShoppingLists(shoppingLists: shoppingLists));
            return ShoppingLists(shoppingLists: shoppingLists);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
