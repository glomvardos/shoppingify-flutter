import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';
import 'package:shoppingify/widgets/items/categories_header.dart';
import 'package:shoppingify/widgets/items/items_list.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
        future: context.read<CategoriesService>().fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('You haven\'t added any categories yet'),
              );
            }

            final List<Item> allItems = snapshot.data!;
            final Map<String, List<Item>> uniqueCategories = {};
            for (var item in allItems) {
              if (!uniqueCategories.containsKey(item.category)) {
                uniqueCategories[item.category] = [item];
              } else {
                uniqueCategories[item.category]!.add(item);
              }
            }
            List<Widget> categories = <Widget>[];
            uniqueCategories.forEach((key, value) {
              categories.add(ItemsList(categoryName: key, item: value));
            });

            return Column(
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const CategoriesHeader(),
                          const SizedBox(
                            height: 20,
                          ),
                          ...categories
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        });
  }
}
