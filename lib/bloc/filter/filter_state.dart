part of 'filter_bloc.dart';

abstract class FilterState extends Equatable {
  const FilterState();


  get currentStatus => ShoppingListStatus.all;

  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final List<ShoppingList> filteredShoppingLists;
  final ShoppingListStatus status;
  
  @override
  get currentStatus => status;

  const FilterLoaded({
    required this.filteredShoppingLists,
    this.status = ShoppingListStatus.all,
  });

  @override
  List<Object> get props => [filteredShoppingLists, status];
}
