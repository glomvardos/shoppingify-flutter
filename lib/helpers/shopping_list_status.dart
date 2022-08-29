import 'package:flutter/material.dart';
import 'package:shoppingify/models/shoppinglist.dart';

class ShoppingListStatus {
  static Map<String, dynamic> status(ShoppingList list) {
    if (list.isActive) {
      return {
        "status": "Active",
        "color": Colors.greenAccent,
      };
    } else if (list.isCompleted) {
      return {
        "status": "Completed",
        "color": const Color(0xFF56CCF2),
      };
    } else if (list.isCancelled) {
      return {
        "status": "Cancelled",
        "color": const Color(0xFFEB5757),
      };
    } else {
      return {
        "status": "Inactive",
        "color": const Color(0xFFC1C1C4),
      };
    }
  }
}
