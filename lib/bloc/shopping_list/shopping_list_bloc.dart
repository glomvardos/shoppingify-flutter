import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shoppingify/models/item.dart';

part 'shopping_list_event.dart';
part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListLoading()) {
    on<InitialItems>((event, emit) {
      emit(const ShoppingListLoaded(items: []));
    });

    on<AddItem>((event, emit) {
      final state = this.state;
      if (state is ShoppingListLoaded) {
        if (state.items.contains(event.item)) {
          // if the item is already in the list, increment the quantity
          final items = [...state.items];
          final index = items.indexOf(event.item);
          event.item.quantity += 1;
          items[index] = event.item;

          emit(ShoppingListLoaded(items: items));
        } else {
          emit(ShoppingListLoaded(items: [...state.items, event.item]));
        }
      }
    });
  }
}
