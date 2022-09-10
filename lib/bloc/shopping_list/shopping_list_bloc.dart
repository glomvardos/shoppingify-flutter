import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoppingify/models/item.dart';
import 'package:shoppingify/models/shoppinglist.dart';

part 'shopping_list_event.dart';

part 'shopping_list_state.dart';

class ShoppingListBloc extends Bloc<ShoppingListEvent, ShoppingListState> {
  ShoppingListBloc() : super(ShoppingListLoading()) {
    on<InitialItems>((event, emit) {
      emit(const ShoppingListLoaded(items: [], shoppingLists: []));
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

          emit(ShoppingListLoaded(
            items: items,
            shoppingLists: state.shoppingLists,
          ));
        } else {
          emit(
            ShoppingListLoaded(
                items: [...state.items, event.item],
                shoppingLists: state.shoppingLists),
          );
        }
      }
    });

    on<IncrementQuantity>((event, emit) {
      final state = this.state;
      if (state is ShoppingListLoaded) {
        event.item.quantity += 1;
        final index = state.items.indexOf(event.item);
        state.items.removeAt(index);

        emit(
          ShoppingListLoaded(
            items: List.from(state.items)..insert(index, event.item),
            shoppingLists: state.shoppingLists,
          ),
        );
      }
    });

    on<DecrementQuantity>((event, emit) {
      final state = this.state;
      if (state is ShoppingListLoaded) {
        if (event.item.quantity == 1) {
          emit(
            ShoppingListLoaded(
              items: List.from(state.items)..remove(event.item),
              shoppingLists: state.shoppingLists,
            ),
          );
        } else {
          event.item.quantity -= 1;
          final index = state.items.indexOf(event.item);
          state.items.removeAt(index);

          emit(
            ShoppingListLoaded(
              items: List.from(state.items)..insert(index, event.item),
              shoppingLists: state.shoppingLists,
            ),
          );
        }
      }
    });

    on<AddShoppingLists>((event, emit) {
      final state = this.state;
      if (state is ShoppingListLoaded) {
        emit(ShoppingListLoaded(
            items: state.items, shoppingLists: event.shoppingLists));
      }
    });
  }
}
