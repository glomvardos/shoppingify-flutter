import 'package:flutter/material.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/api/api.dart';
import 'package:shoppingify/widgets/items/categories_header.dart';
import 'package:shoppingify/widgets/items/items_list.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final _api = ApiService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Item>>(
        future: _api.fetchItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                      physics: const AlwaysScrollableScrollPhysics(),
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
