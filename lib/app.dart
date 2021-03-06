import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/auth/authentication_bloc.dart';
import 'package:shoppingify/screens/add_new_item_screen.dart';
import 'package:shoppingify/screens/item_screen.dart';
import 'package:shoppingify/screens/auth/login.dart';
import 'package:shoppingify/screens/auth/register.dart';
import 'package:shoppingify/screens/shopping_list_screen.dart';
import 'package:shoppingify/widgets/bottom_bar/bottom_bar.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        Login.routeName: (_) => const Login(),
        Register.routeName: (_) => const Register(),
        AddNewItemScreen.routeName: (_) => const AddNewItemScreen(),
        ItemScreen.routeName: (_) => const ItemScreen(),
        ShoppingListScreen.routeName: (_) => const ShoppingListScreen(),
      },
    );
  }
}
