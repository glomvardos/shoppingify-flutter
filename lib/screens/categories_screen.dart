import 'package:flutter/material.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/api/api.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  final _api = ApiService();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              RichText(
                  text: TextSpan(
                text: 'Shoppingify',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
                children: const [
                  TextSpan(
                    text:
                        ' allows you to take your shopping list wherever you go',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              )),
              FutureBuilder<List<Item>>(
                  future: _api.fetchItems(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final categoriesMap =
                          snapshot.data!.map((item) => item.keyCategory);
                      final Map<String, List<Map<String, dynamic>>>
                          uniqueCategories = {};

                      categoriesMap.forEach((item) {
                        item.keys.forEach((key) {
                          if (!uniqueCategories.containsKey(key)) {
                            uniqueCategories[key] = [];
                          }
                          item.values.forEach((value) {
                            if (value['category'] == key) {
                              uniqueCategories[key]!.add(value);
                            }
                          });
                        });
                      });

                      List<Widget> categories = <Widget>[];
                      uniqueCategories.forEach((key, value) {
                        categories.add(Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(key),
                              Wrap(
                                children: value
                                    .map(
                                      (item) => Container(
                                        width:
                                            (MediaQuery.of(context).size.width *
                                                    0.50) -
                                                20,
                                        child: Card(
                                          elevation: 3,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                item['name'],
                                              ),
                                              Text(
                                                item['name'],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              )
                            ],
                          ),
                        ));
                        print(key);
                        print(value);
                      });
                      return Column(
                        children: categories,
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    ]);
  }
}
