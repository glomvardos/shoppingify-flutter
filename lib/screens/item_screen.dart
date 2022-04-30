import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shoppingify/enums/button-type.dart';
import 'package:shoppingify/services/api/api.dart';
import 'package:shoppingify/widgets/ui/button.dart';

class ItemScreen extends StatefulWidget {
  const ItemScreen({Key? key}) : super(key: key);
  static const String routeName = '/item';

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  bool _isLoading = false;
  final ApiService _api = ApiService();

  _onDeleteItem(int id) async {
    try {
      setState(() {
        _isLoading = true;
      });
      await _api.deleteItem(id);
      Navigator.of(context).popAndPushNamed('/');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Item has been deleted successfully'),
        ),
      );
    } on DioError catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.response != null
              ? e.response!.data['message'] ?? 'Something went wrong'
              : 'Something went wrong'),
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    final item =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
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
                            onPressedHandler: () => _onDeleteItem(item['id'])),
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
