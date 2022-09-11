enum ShoppingListStatus {
  all,
  inactive,
  completed,
  cancelled,
}

Map<ShoppingListStatus, String> shoppingListStatusNames = {
  ShoppingListStatus.all: 'All',
  ShoppingListStatus.inactive: 'Inactive',
  ShoppingListStatus.completed: 'Completed',
  ShoppingListStatus.cancelled: 'Cancelled',
};
