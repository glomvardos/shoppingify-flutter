import 'package:flutter/material.dart';
import 'package:shoppingify/helpers/string_methods.dart';
import 'package:shoppingify/models/item.dart';

class ItemCheckBox extends StatefulWidget {
  const ItemCheckBox({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<ItemCheckBox> createState() => _ItemCheckBoxState();
}

class _ItemCheckBoxState extends State<ItemCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        unselectedWidgetColor: Theme.of(context).colorScheme.primary,
      ),
      child: CheckboxListTile(
        value: widget.item.isChecked,
        onChanged: (value) {
          setState(() {
            widget.item.isChecked = value!;
          });
        },
        contentPadding: const EdgeInsets.all(0),
        checkColor: Colors.white,
        activeColor: Theme.of(context).colorScheme.primary,
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(
          StringMethods.capitalizeString(widget.item.name),
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              decoration: widget.item.isChecked
                  ? TextDecoration.lineThrough
                  : TextDecoration.none),
        ),
        secondary: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: const Color(0xFFFFF0DE),
            border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 2,
            ),
          ),
          width: 70,
          height: 30,
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
              '${widget.item.quantity} pcs',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
