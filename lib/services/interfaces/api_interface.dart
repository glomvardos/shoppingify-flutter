import 'package:dio/dio.dart';
import 'package:shoppingify/models/item.dart';

abstract class CategoriesService {
  Future<Response> addNewItem(Item item);
  Future<List<Item>> fetchItems();
  Future<Response> deleteItem(int id);
}

abstract class ApiService implements CategoriesService {}
