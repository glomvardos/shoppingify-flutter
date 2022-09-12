part of 'filter_bloc.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object> get props => [];
}

class FilterList extends FilterEvent {
  final ShoppingListStatus status;

  const FilterList({
    this.status = ShoppingListStatus.all,
  });

  @override
  List<Object> get props => [status];
}
