import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/models/category.dart';
import 'package:shoppingify/screens/add_new_item_screen/widgets/new_item_form.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';

class AddNewItemScreen extends StatelessWidget {
  const AddNewItemScreen({Key? key}) : super(key: key);
  static const routeName = '/add-new-item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 19,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: FutureBuilder(
        future: context.read<CategoriesService>().fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            } else {
              return NewItemForm(
                categories: snapshot.data as List<Category>,
              );
            }
          }
        },
      ),
    );
  }
}
