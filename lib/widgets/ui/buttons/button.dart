import 'package:flutter/material.dart';
import 'package:shoppingify/enums/button_type.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.type,
    required this.text,
    required this.onPressedHandler,
    this.isDisabled = false,
  }) : super(key: key);

  final ButtonType type;
  final String text;
  final Function onPressedHandler;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return ButtonType.primary == type
        ? ElevatedButton(
            onPressed: () => isDisabled ? null : onPressedHandler(),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(
                isDisabled
                    ? Colors.grey
                    : Theme.of(context).colorScheme.primary,
              ),
              elevation: MaterialStateProperty.all(0),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
            ),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          )
        : TextButton(
            onPressed: () => isDisabled ? null : onPressedHandler(),
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          );
  }
}
