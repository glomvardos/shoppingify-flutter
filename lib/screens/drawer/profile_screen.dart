import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/auth/authentication_bloc.dart';
import 'package:shoppingify/models/user.dart';
import 'package:shoppingify/services/interfaces/auth_interface.dart';
import 'package:shoppingify/utils/shared_prefs.dart';
import 'package:shoppingify/widgets/alert_dialog/custom_alert_dialog.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  final User user = User.fromJson(json.decode(sharedPrefs.getKey('user')));

  @override
  Widget build(BuildContext context) {
    Future<void> _onDeleteUser() async {
      final bool response = await showDialog(
          context: context,
          builder: (context) {
            return const CustomAlertDialog(
                title: 'Delete Account',
                content: 'Are you sure you want to delete your account?',
                cancelButtonText: 'Cancel',
                confirmButtonText: 'Delete');
          });
      if (response == true) {
        context
            .read<AuthenticationService>()
            .deleteUser()
            .then((_) => {
                  context.read<AuthenticationBloc>().add(LogoutEvent()),
                  Navigator.of(context).pop()
                })
            .catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(
                  error.response!.data['message'] ?? 'Something went wrong'),
            ),
          );
        });
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 30),
          alignment: Alignment.center,
          child: Column(
            children: [
              const Icon(Icons.account_circle, size: 120),
              Text(
                "${user.firstName} ${user.lastName}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Text(
                user.email,
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              TextButton(
                  onPressed: _onDeleteUser,
                  child: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.redAccent),
                  ))
            ],
          ),
        ));
  }
}
