import 'package:flutter/material.dart';
import 'package:shoppingify/widgets/ui/form_button.dart';
import 'package:shoppingify/widgets/ui/input_field.dart';
import 'package:shoppingify/widgets/ui/label.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _autoValidate = false;
  final TextEditingController _emaiController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _onUserLogin() {
    if (_formKey.currentState!.validate()) {
    } else {
      setState(() => _autoValidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
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
                                'Shopingify',
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 50),
                            const Label(text: 'Email'),
                            const SizedBox(height: 10),
                            InputField(
                              labelText: 'Enter your Email',
                              controller: _emaiController,
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
                            const SizedBox(height: 40),
                            FormButton(
                                text: 'Login', onClickHandler: _onUserLogin)
                          ],
                        ),
                      ),
                    )),
              ))
        ],
      ),
    );
  }
}
