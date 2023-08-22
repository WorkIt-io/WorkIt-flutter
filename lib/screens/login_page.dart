import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/custom_snack_bar.dart.dart';
import 'package:workit/utils/login_page_helper.dart';

import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isLogin = true;
  bool _isLoading = false;

  final _form = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  Future<void> onLogin() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();
      setState(() => _isLoading = true);
      try {
        _isLogin == true
            ? await ref
                .read(authControllerProvider)
                .login(context, _email, _password)
            : await ref
                .read(authControllerProvider)
                .signup(context, _email, _password);
      } on FirebaseAuthException catch (e) {
        CustomSnackBar.showSnackBar(context, e.message!);
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                    top: 50, bottom: 20, left: 20, right: 20),
                width: 250,
                child: Image.asset(
                  'assets/images/workit_logo_no_bg.png',
                ),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'email'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) =>
                              LoginPageHelper.validateEmail(value),
                          onSaved: (newValue) => _email = newValue!,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          obscureText: true,
                          validator: (value) =>
                              LoginPageHelper.validatePassword(value),
                          onSaved: (newValue) => _password = newValue!,
                        ),
                        const SizedBox(height: 16),
                        if (_isLoading) const CircularProgressIndicator(),
                        if (!_isLoading)
                          ElevatedButton(
                            onPressed: onLogin,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: Text(_isLogin ? 'Login' : 'Signup'),
                          ),
                        if (!_isLoading)
                          TextButton(
                              onPressed: () => setState(() {
                                    _isLogin = !_isLogin;
                                  }),
                              child: Text(_isLogin
                                  ? 'Create an account'
                                  : 'I already have an account')),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
