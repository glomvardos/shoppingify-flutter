import 'package:dio/dio.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';

class ShoppingListApi implements ShoppingListService {
  final Dio client;
  ShoppingListApi({required this.client});

  @override
  Future<Response> addNewList(List<Item> item, String name) async {
    try {
      final Response response =
          await client.post('/shoppinglist/shoppinglist', data: {
        "name": name,
        "categories": item.map((item) => item.toJson()).toList(),
      });
      return response;
    } on DioError {
      rethrow;
    }
  }
}
