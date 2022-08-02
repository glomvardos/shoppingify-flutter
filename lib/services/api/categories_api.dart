import 'package:dio/dio.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';

class CategoriesApi implements CategoriesService {
  final Dio client;

  CategoriesApi({required this.client});

  @override
  Future<Response> addNewItem(Item item) async {
    final Response response = await client.post(
      '/category/item',
      data: item.toJson(),
    );

    return response;
  }

  @override
  Future<List<Item>> fetchItems() async {
    final Response response = await client.get(
      '/category/item',
    );

    return (response.data['items'] as List)
        .map((item) => Item.fromJson(item))
        .toList();
  }

  @override
  Future<Response> deleteItem(int id) async {
    final Response response = await client.delete('/category/item/$id');

    return response;
  }
}
