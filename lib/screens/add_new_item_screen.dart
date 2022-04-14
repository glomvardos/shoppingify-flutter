import 'package:flutter/material.dart';

class AddNewItemScreen extends StatelessWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);
  static const routeName = '/add-new-item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add New Item'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: const SizedBox(child: Text('Add new item')));
  }
}
