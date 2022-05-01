part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListEvent {}

class InitialItems extends ShoppingListEvent {}

class AddItem extends ShoppingListEvent {
  final Map<String, dynamic> item;

  AddItem({required this.item});
}
