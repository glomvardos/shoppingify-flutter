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
        final items = [...state.items];
        final isAlreadyAdded = items.any((item) => item.id == event.item.id);

        if (isAlreadyAdded == true) {
          // if the item is already in the list, increment the quantity
          final findAddedItem =
              items.firstWhere((item) => item.id == event.item.id);
          final index = items.indexWhere((item) => item.id == event.item.id);

          findAddedItem.quantity += 1;
          items[index] = findAddedItem;

          emit(ShoppingListLoaded(items: items));
        } else {
          emit(ShoppingListLoaded(items: [...state.items, event.item]));
        }
      }
    });
  }
}
