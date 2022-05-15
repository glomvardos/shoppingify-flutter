import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/widgets/ui/buttons/list_item_button.dart';

class ShoppingListItem extends StatefulWidget {
  const ShoppingListItem({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<ShoppingListItem> createState() => _ShoppingListItemState();
}

class _ShoppingListItemState extends State<ShoppingListItem> {
  bool _showButtons = false;

  void onItemClickHandler() => setState(() => _showButtons = !_showButtons);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: Text(
        StringMethods.capitalizeString(widget.item.name),
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: _showButtons
          ? Container(
              width: 175,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      context.read<ShoppingListBloc>().add(
                            DecrementQuantity(item: widget.item),
                          );
                    },
                  ),
                  ListItemButton(
                    onClickHandler: onItemClickHandler,
                    quantity: widget.item.quantity.toString(),
                    isSelected: _showButtons,
                  ),
                  IconButton(
                    color: Theme.of(context).colorScheme.primary,
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<ShoppingListBloc>().add(
                            IncrementQuantity(item: widget.item),
                          );
                    },
                  ),
                ],
              ),
            )
          : ListItemButton(
              onClickHandler: onItemClickHandler,
              quantity: widget.item.quantity.toString(),
            ),
    );
  }
}
