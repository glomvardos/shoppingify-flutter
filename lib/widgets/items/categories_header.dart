import 'package:flutter/material.dart';

class CategoriesHeader extends StatelessWidget {
  const CategoriesHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'Shoppingify',
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
      children: const [
        TextSpan(
          text: ' allows you to take your shopping list wherever you go',
          style: TextStyle(color: Colors.black),
        ),
      ],
    ));
  }
}
