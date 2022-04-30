import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/bloc/authentication_bloc.dart';
import 'package:shoppingify/screens/auth/register.dart';
import 'package:shoppingify/widgets/ui/form_button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onUserLogin() {
      if (_formKey.currentState!.validate()) {
        context.read<AuthenticationBloc>().add(LoginEvent(
            email: _emailController.text, password: _passwordController.text));
      } else {
        setState(() => _autoValidate = true);
      }
    }

    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is AuthenticationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(state.message),
            ),
          );
        }
      },
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationNotAuthenticated) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Card(
                      elevation: 4,
                      child: Container(
                        padding: const EdgeInsets.all(30),
                        height: 500,
                        width: mediaQuery * 0.85,
                        child: Form(
                          key: _formKey,
                          autovalidateMode: _autoValidate
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Shoppingify',
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 50),
                              const Label(text: 'Email'),
                              const SizedBox(height: 10),
                              InputField(
                                labelText: 'Enter your Email',
                                controller: _emailController,
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => value!.isEmpty
                                    ? "Email can't be empty"
                                    : null,
                              ),
                              const SizedBox(height: 30),
                              const Label(text: 'Password'),
                              const SizedBox(height: 10),
                              InputField(
                                labelText: 'Enter your Password',
                                controller: _passwordController,
                                obscureText: true,
                                keyboardType: TextInputType.text,
                                validator: (value) => value!.isEmpty
                                    ? "Password can't be empty"
                                    : null,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text(
                                    "You don't have an account?",
                                    style: TextStyle(fontSize: 13),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed(Register.routeName);
                                      },
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ))
                                ],
                              ),
                              const SizedBox(height: 10),
                              FormButton(
                                  text: 'Login', onClickHandler: _onUserLogin)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    ));
  }
}
