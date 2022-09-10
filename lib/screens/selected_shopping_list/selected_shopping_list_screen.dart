import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/enums/button_type.dart';
import 'package:shoppingify/helpers/shopping_list_status.dart';
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

class SelectedShoppingListScreen extends StatefulWidget {
  const SelectedShoppingListScreen({Key? key}) : super(key: key);
  static const routeName = '/selected-shopping-list';

  @override
  State<SelectedShoppingListScreen> createState() =>
      _SelectedShoppingListScreenState();
}

class _SelectedShoppingListScreenState
    extends State<SelectedShoppingListScreen> {
  late ShoppingList _shoppingList;
  bool isListCompleted = false;

  @override
  void didChangeDependencies() {
    _shoppingList = ModalRoute.of(context)?.settings.arguments as ShoppingList;
    isListCompleted = _shoppingList.categories.every((item) => item.isChecked);
    super.didChangeDependencies();
  }

  void _checkIfListIsCompleted() {
    setState(() {
      isListCompleted =
          _shoppingList.categories.every((item) => item.isChecked);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> buttonDialog(String text) async {
      final capitalizedText = StringMethods.capitalizeString(text);
      return await showDialog(
          barrierDismissible: false,
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
          .updateShoppingList(_shoppingList.id!, isCompleted, isCancelled)
          .then((_) => {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green,
                    content: Text(text),
                  ),
                ),
                Navigator.of(context)
                    .pushReplacementNamed(BottomNavBar.routeName, arguments: 1)
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

    final Map<String, List<Item>> items = {};

    for (var item in _shoppingList.categories) {
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
          isCheckBoxNotEnabled:
              _shoppingList.isCompleted || _shoppingList.isCancelled,
          listId: _shoppingList.id,
          checkIfListIsCompleted: _checkIfListIsCompleted,
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
                          children: const [
                            GoBackBtn(),
                          ],
                        ),
                        const ShoppingListHeader(),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              child: Text(
                                _shoppingList.name,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: ShoppingListStatus.status(
                                      _shoppingList)['color'],
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                ShoppingListStatus.status(
                                    _shoppingList)['status'],
                                style: TextStyle(
                                  color: ShoppingListStatus.status(
                                      _shoppingList)['color'],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          ],
                        ),
                        ...displayItems,
                      ],
                    ),
                  ),
                ),
                if (!_shoppingList.isCancelled && !_shoppingList.isCompleted)
                  Container(
                    padding: const EdgeInsets.only(
                        left: 25, right: 25, top: 25, bottom: 35),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Button(
                          type: ButtonType.secondary,
                          isDisabled: _shoppingList.isCompleted ||
                              _shoppingList.isCancelled,
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
                          isDisabled:
                              !isListCompleted || _shoppingList.isCompleted,
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
