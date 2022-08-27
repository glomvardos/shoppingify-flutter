import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/enums/button_type.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/models/shoppinglist.dart';
import 'package:shoppingify/screens/shopping_list/widgets/shopping_list_items.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';
import 'package:shoppingify/widgets/alert_dialog/custom_alert_dialog.dart';
import 'package:shoppingify/widgets/bottom_bar/bottom_bar.dart';
import 'package:shoppingify/widgets/ui/buttons/button.dart';
import 'package:shoppingify/widgets/ui/buttons/go_back_btn.dart';
import 'package:shoppingify/widgets/ui/shopping_list_header.dart';

class SelectedShoppingListScreen extends StatelessWidget {
  const SelectedShoppingListScreen({Key? key}) : super(key: key);
  static const routeName = '/selected-shopping-list';

  @override
  Widget build(BuildContext context) {
    final shoppingList =
        ModalRoute.of(context)?.settings.arguments as ShoppingList;
    final Map<String, List<Item>> items = {};

    Future<bool> buttonDialog(String text) async {
      final capitalizedText = StringMethods.capitalizeString(text);
      return await showDialog(
          context: context,
          builder: (context) {
            return CustomAlertDialog(
              title: '$capitalizedText List',
              content: 'Are you sure you want to $text your list?',
              cancelButtonText: 'No',
              confirmButtonText: capitalizedText,
            );
          });
    }

    void onSubmitListAction(bool isCompleted, bool isCancelled, String text) {
      context
          .read<ShoppingListService>()
          .updateShoppingList(shoppingList.id!, isCompleted, isCancelled)
          .then((_) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(text),
                  ),
                ),
                Navigator.of(context).pushNamedAndRemoveUntil(
                    BottomNavBar.routeName,
                    (Route<dynamic> route) =>
                        route.settings.name == BottomNavBar.routeName)
              })
          .catchError((error) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text(
                      error.response?.data['message'] ?? 'Something went wrong',
                    ),
                  ),
                )
              });
    }

    for (var item in shoppingList.categories) {
      if (!items.containsKey(item.category)) {
        items[item.category] = [item];
      } else {
        items[item.category]!.add(item);
      }
    }

    final List<Widget> displayItems = [];
    items.forEach((category, items) {
      displayItems.add(
        ShoppingListItems(
          categoryName: category,
          items: items,
          isListOfCheckBoxes: true,
          listId: shoppingList.id,
        ),
      );
    });

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFFFF0DE),
        child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const GoBackBtn(),
                            Button(
                                type: ButtonType.primary,
                                text: shoppingList.isActive
                                    ? 'Make Inactive'
                                    : 'Make Active',
                                onPressedHandler: () {})
                          ],
                        ),
                        const ShoppingListHeader(),
                        const SizedBox(height: 20),
                        Text(
                          shoppingList.name,
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        ...displayItems,
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 25, bottom: 35),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Button(
                        type: ButtonType.secondary,
                        text: 'cancel',
                        onPressedHandler: () async {
                          final res = await buttonDialog('cancel');
                          if (res) {
                            onSubmitListAction(false, true,
                                'Your list has been cancelled successfully');
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                      Button(
                        type: ButtonType.primary,
                        text: 'Complete',
                        onPressedHandler: () async {
                          final res = await buttonDialog('complete');
                          if (res) {
                            onSubmitListAction(true, false,
                                'Your list has been completed successfully');
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
