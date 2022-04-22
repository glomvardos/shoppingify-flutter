import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingify/screens/login.dart';
import 'package:shoppingify/services/authentication.dart';
import 'package:shoppingify/widgets/ui/form_button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _firstnameController.dispose();
    _lastnameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onUserRegistration() async {
      if (_formKey.currentState!.validate()) {
        try {
          setState(() {
            _isLoading = true;
          });
          await context.read<AuthenticationService>().register(
              _firstnameController.text,
              _lastnameController.text,
              _emailController.text,
              _passwordController.text);
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text('User registered successfully'),
            ),
          );
        } on DioError catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.redAccent,
              content: Text(e.response != null
                  ? e.response!.data['message'] ?? 'Something went wrong'
                  : 'Something went wrong'),
            ),
          );
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : Card(
                        elevation: 4,
                        child: Container(
                          padding: const EdgeInsets.all(30),
                          height: 710,
                          width: mediaQuery.width * 0.85,
                          child: Form(
                            key: _formKey,
                            autovalidateMode: AutovalidateMode.disabled,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Shoppingify',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                const Label(text: 'First Name'),
                                const SizedBox(height: 10),
                                InputField(
                                  labelText: 'Enter your first name',
                                  controller: _firstnameController,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  validator: (value) => value!.isEmpty
                                      ? "First name can't be empty"
                                      : null,
                                ),
                                const SizedBox(height: 15),
                                const Label(text: 'Last name'),
                                const SizedBox(height: 10),
                                InputField(
                                  labelText: 'Enter your last name',
                                  controller: _lastnameController,
                                  obscureText: false,
                                  keyboardType: TextInputType.text,
                                  validator: (value) => value!.isEmpty
                                      ? "Last name can't be empty"
                                      : null,
                                ),
                                const SizedBox(height: 15),
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
                                const SizedBox(height: 15),
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
                                      "Already have an account?",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Login.routeName);
                                        },
                                        child: Text(
                                          'Login',
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
                                    text: 'Register',
                                    onClickHandler: _onUserRegistration),
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
