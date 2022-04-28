import 'package:flutter/material.dart';
import 'package:shoppingify/enums/button-type.dart';
import 'package:shoppingify/widgets/ui/button.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/item';

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 250,
                      child: Image.network(
                        item['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalize(item['category']),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            capitalize(item['name']),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            item['note'],
                            style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.keyboard_backspace,
                      size: 30,
                    ),
                  ),
                  const Spacer(),
                  Button(
                      type: ButtonType.secondary,
                      text: 'delete',
                      onPressedHandler: () {}),
                  const SizedBox(width: 20),
                  Button(
                      type: ButtonType.primary,
                      text: 'Add to list',
                      onPressedHandler: () {}),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
