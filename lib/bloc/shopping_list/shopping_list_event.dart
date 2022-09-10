part of 'shopping_list_bloc.dart';

abstract class ShoppingListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialItems extends ShoppingListEvent {}

class AddItem extends ShoppingListEvent {
  final Item item;

  AddItem({required this.item});

  @override
  List<Object> get props => [item];
}

class IncrementQuantity extends ShoppingListEvent {
  final Item item;

  IncrementQuantity({required this.item});

  @override
  List<Object> get props => [item];
}

class DecrementQuantity extends ShoppingListEvent {
  final Item item;

  DecrementQuantity({required this.item});

  @override
  List<Object> get props => [item];
}

class AddShoppingLists extends ShoppingListEvent {
  final List<ShoppingList> shoppingLists;

  AddShoppingLists({required this.shoppingLists});

  @override
  List<Object> get props => [shoppingLists];
}
