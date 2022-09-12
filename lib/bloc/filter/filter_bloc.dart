import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/enums/shopping_list_status.dart';
import 'package:shoppingify/models/shoppinglist.dart';

part 'filter_event.dart';

part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final ShoppingListBloc _shoppingListBloc;
  late StreamSubscription _shoppingListSubscription;

  FilterBloc({required ShoppingListBloc shoppingListBloc})
      : _shoppingListBloc = shoppingListBloc,
        super(FilterLoading()) {
    _shoppingListSubscription = _shoppingListBloc.stream.listen((state) {
      add(const FilterList());
    });

    on<FilterList>((event, emit) {
      final state = _shoppingListBloc.state;

      if (state is ShoppingListLoaded) {
        List<ShoppingList> shoppingLists = state.shoppingLists.where((list) {
          switch (event.status) {
            case ShoppingListStatus.all:
              return true;
            case ShoppingListStatus.completed:
              return list.isCompleted;
            case ShoppingListStatus.cancelled:
              return list.isCancelled;
            case ShoppingListStatus.inactive:
              return !list.isCompleted && !list.isCancelled;
          }
        }).toList();

        emit(FilterLoaded(
          filteredShoppingLists: shoppingLists,
          status: event.status,
        ));
      }
    });
  }
}
