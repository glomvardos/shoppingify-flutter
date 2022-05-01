import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
          event.item.update('quantity', (value) => value + 1);
          items.remove(event.item);
          emit(ShoppingListLoaded(items: [...items, event.item]));
        } else {
          // If the item is not in the list, add quantity to the item
          event.item['quantity'] = 1;
          emit(ShoppingListLoaded(items: [...state.items, event.item]));
        }
      }
    });
  }
}
