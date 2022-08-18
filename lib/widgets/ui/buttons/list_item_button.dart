import 'package:flutter/material.dart';

class ListItemButton extends StatelessWidget {
  const ListItemButton({
    Key? key,
    required this.onClickHandler,
    required this.quantity,
    this.isSelected = false,
  }) : super(key: key);

  final Function onClickHandler;
  final String quantity;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isSelected ? Colors.white : const Color(0xFFFFF0DE),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
        onPressed: () => onClickHandler(),
        child: FittedBox(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: Text(
              '$quantity pcs',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              key: ValueKey(quantity),
            ),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}
