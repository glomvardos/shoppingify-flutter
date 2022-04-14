import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/authentication_bloc.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          const SizedBox(height: 30),
          Text(
            'Shoppingify',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(
              Icons.logout_rounded,
              size: 27,
              color: Colors.black,
            ),
            title: const Text('Log out',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            onTap: () {
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
            },
          )
        ],
      ),
    );
  }
}
