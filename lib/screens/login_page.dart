import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workit/utils/login_page_helper.dart';
import '../constant/firebase_instance.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLogin = true;
  bool _isLoading = false;

  final _form = GlobalKey<FormState>();
  var _email = '';
  var _password = '';

  Future<void> onLogin() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();       

      try {
        setState(() => _isLoading = true );
        final UserCredential userCredential = _isLogin ?
         await firebaseInstance.signInWithEmailAndPassword(email: _email, password: _password) 
         : await firebaseInstance.createUserWithEmailAndPassword(email: _email, password: _password);

      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error.message ?? 'Authentication failed.')));
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
                          decoration:
                              const InputDecoration(labelText: 'email'),
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
                        if(_isLoading)
                          const CircularProgressIndicator(),
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
                              onPressed: () {
                                setState(() {
                                  _isLogin = !_isLogin;
                                });
                              },
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
