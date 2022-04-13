import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/app.dart';
import 'package:shoppingify/bloc/authentication_bloc.dart';
import 'package:shoppingify/services/authentication.dart';

void main() {
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationService>(
          create: (context) => AuthenticationApiService(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) =>
                  AuthenticationBloc(context.read<AuthenticationService>())
                    ..add(Initialize()))
        ],
        child: const App(),
      ),
    ),
  );
}
