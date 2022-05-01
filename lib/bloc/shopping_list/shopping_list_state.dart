part of 'shopping_list_bloc.dart';

@immutable
abstract class ShoppingListState extends Equatable {
  const ShoppingListState();

  @override
  List<Object> get props => [];
}

class ShoppingListInitial extends ShoppingListState {}

class ShoppingListLoading extends ShoppingListState {}

class ShoppingListLoaded extends ShoppingListState {
  final List<Map<String, dynamic>> items;

  const ShoppingListLoaded({required this.items});

  @override
  List<Object> get props => [items];
}
