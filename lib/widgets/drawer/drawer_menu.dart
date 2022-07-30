import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/auth/authentication_bloc.dart';
import 'package:shoppingify/screens/drawer/profile_screen.dart';
import 'package:shoppingify/widgets/drawer/drawer_item.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          DrawerHeader(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Shoppingify',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          )),
          DrawerItem(
            icon: Icons.account_circle,
            text: 'Profile',
            onTapHandler: () =>
                Navigator.of(context).pushNamed(ProfileScreen.routeName),
          ),
          DrawerItem(
            icon: Icons.logout_rounded,
            text: 'Log out',
            onTapHandler: () =>
                BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent()),
          ),
        ],
      ),
    );
  }
}
