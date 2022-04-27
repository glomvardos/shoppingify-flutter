import 'package:flutter/material.dart';
import 'package:shoppingify/models/item.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key, required this.categoryName, required this.item})
      : super(key: key);

  final String categoryName;
  final List<Map<String, dynamic>> item;

  String capitalizeString(String text) =>
      text[0].toUpperCase() + text.substring(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(capitalizeString(categoryName),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              )),
          const SizedBox(height: 5),
          Wrap(
            children: item
                .map(
                  (value) => SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.50) - 20,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 2,
                      color: Colors.white,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              capitalizeString(value['name']),
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            IconButton(
                              onPressed: () {},
                              constraints: const BoxConstraints(maxHeight: 36),
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xFFC1C1C4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
