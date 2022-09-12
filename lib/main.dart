import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/app.dart';
import 'package:shoppingify/bloc/auth/authentication_bloc.dart';
import 'package:shoppingify/bloc/shopping_list/shopping_list_bloc.dart';
import 'package:shoppingify/bloc/filter/filter_bloc.dart';
import 'package:shoppingify/services/api/categories_api.dart';
import 'package:shoppingify/services/api/shopping_list_api.dart';
import 'package:shoppingify/services/auth/authentication.dart';
import 'package:shoppingify/services/interfaces/api_interface.dart';
import 'package:shoppingify/services/interfaces/auth_interface.dart';
import 'package:shoppingify/utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefs.init();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationService>(
          create: (context) => AuthenticationApi(),
        ),
        RepositoryProvider<CategoriesService>(
          create: (context) => CategoriesApi(
              client: context.read<AuthenticationService>().client),
        ),
        RepositoryProvider<ShoppingListService>(
          create: (context) => ShoppingListApi(
              client: context.read<AuthenticationService>().client),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(context.read<AuthenticationService>())
                  ..add(Initialize()),
          ),
          BlocProvider<ShoppingListBloc>(
            create: (context) => ShoppingListBloc()..add(InitialItems()),
          ),
          BlocProvider<FilterBloc>(
            create: (context) => FilterBloc(
              shoppingListBloc: context.read<ShoppingListBloc>(),
            ),
          ),
        ],
        child: const App(),
      ),
    ),
  );
}
