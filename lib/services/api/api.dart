import 'package:dio/dio.dart';
import 'package:shoppingify/config.dart';
import 'package:shoppingify/models/item.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: Config.API_URL));

  Future<Response> addNewItem(Item item) async {
    final Response response =
        await _dio.post('/category/item', data: item.toJson());

    return response;
  }

  Future<List<Item>> fetchItems() async {
    final Response response = await _dio.get('/category/item');

    return (response.data['items'] as List)
        .map((item) => Item.fromJson(item))
        .toList();
  }
}
