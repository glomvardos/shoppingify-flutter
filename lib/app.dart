import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/auth/authentication_bloc.dart';
import 'package:shoppingify/screens/add_new_item_screen.dart';
import 'package:shoppingify/screens/drawer/profile_screen.dart';
import 'package:shoppingify/screens/history/history_screen.dart';
import 'package:shoppingify/screens/item_screen.dart';
import 'package:shoppingify/screens/auth/login.dart';
import 'package:shoppingify/screens/auth/register.dart';
import 'package:shoppingify/screens/selected_shopping_list/selected_shopping_list_screen.dart';
import 'package:shoppingify/screens/shopping_list/shopping_list_screen.dart';
import 'package:shoppingify/widgets/bottom_bar/bottom_bar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoppingify',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: const Color(0xFFF9A109)),
        fontFamily: 'Quicksand',
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            return const BottomNavBar();
          }
          return const Login();
        },
      ),
      routes: {
        BottomNavBar.routeName: (_) => const BottomNavBar(),
        Login.routeName: (_) => const Login(),
        Register.routeName: (_) => const Register(),
        AddNewItemScreen.routeName: (_) => const AddNewItemScreen(),
        ItemScreen.routeName: (_) => const ItemScreen(),
        ShoppingListScreen.routeName: (_) => const ShoppingListScreen(),
        SelectedShoppingListScreen.routeName: (_) =>
            const SelectedShoppingListScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
      },
    );
  }
}
