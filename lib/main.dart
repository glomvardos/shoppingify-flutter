import 'package:flutter/material.dart';
import 'package:shoppingify/screens/add_new_item_screen.dart';
import 'package:shoppingify/widgets/bottom_bar/bottom_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shoppingify',
      home: const BottomNavBar(),
      routes: {
        AddNewItemScreen.routeName: (_) => const AddNewItemScreen(),
      },
    );
  }
}
