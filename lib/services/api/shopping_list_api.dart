import 'package:dio/dio.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/models/shoppinglist.dart';
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
        "categories":
            item.map((item) => item.shoppingListItemToJson()).toList(),
      });
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<List<ShoppingList>> getShoppingLists() async {
    final Response response = await client.get('/shoppinglist/shoppinglist');
    return (response.data as List)
        .map((list) => ShoppingList.fromJson(list))
        .toList();
  }

  @override
  Future<Response> updateShoppingList(
      int id, bool isCompleted, bool isCancelled) async {
    try {
      final Response response =
          await client.patch('/shoppinglist/shoppinglist/$id', data: {
        "isCompleted": isCompleted,
        "isCancelled": isCancelled,
      });
      return response;
    } on DioError {
      rethrow;
    }
  }

  @override
  Future<ShoppingList> updateShoppingListItem(
      int id, int itemId, bool isChecked) async {
    try {
      final Response response = await client
          .patch('/shoppinglist/shoppinglist/$id/item/$itemId', data: {
        "isChecked": isChecked,
      });
      return ShoppingList.fromJson(response.data);
    } on DioError {
      rethrow;
    }
  }
}
