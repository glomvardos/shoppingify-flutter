part of 'shopping_list_bloc.dart';

abstract class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

class ShoppingListInitial extends ShoppingListState {}

class ShoppingListLoading extends ShoppingListState {}

class ShoppingListLoaded extends ShoppingListState {
  final List<Item> items;
  final List<ShoppingList> shoppingLists;

  const ShoppingListLoaded({required this.items, required this.shoppingLists});

  @override
  List<Object> get props => [items, shoppingLists];
}
