import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/loading_dialog.dart';
import 'package:workit/utils/login_page_helper.dart';
import 'package:workit/widgets/login/login_button.dart';
import 'package:workit/widgets/login/login_square_tile.dart';
import 'package:workit/widgets/login/login_text_field.dart';

import '../controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _form = GlobalKey<FormState>();

  bool _isLogin = true;
  String _email = '';
  String _password = '';
  String _fullName = '';

  Future<void> onLoginOrRegister() async {
    if (_form.currentState!.validate()) {
      _form.currentState!.save();

      startLoadingDialog(context);

      try {
        _isLogin == true
            ? await ref.read(authControllerProvider).login(_email, _password)
            : await ref
                .read(authControllerProvider)
                .signup(_email, _password, _fullName);

        if (Navigator.canPop(context) && context.mounted) Navigator.of(context).pop();        
      } on FirebaseAuthException catch (e) {
        if (context.mounted) Navigator.of(context).pop();
        startErrorDialog(context, title: "Ho No", text: e.message!);
      }
    }
  }

  void changeToRegister() {
    setState(() {
      _form.currentState!.reset();
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          reverse: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                width: 250,
                height: _isLogin ? 200 : 150,
                child: Image.asset(
                  'assets/images/workit_logo_no_bg.png',
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                _isLogin
                    ? 'Welcome back you\'ve been missed!'
                    : 'Let\'s create an account for you!',
                style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 25,
              ),
              Form(
                key: _form,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin)
                      LoginTextField(
                        hintText: 'Full Name',
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.name,
                        validator: LoginPageHelper.validateFullName,
                        onSaved: (value) => _fullName = value!,
                      ),
                    LoginTextField(
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: LoginPageHelper.validateEmail,
                      onSaved: (value) => _email = value!,
                    ),
                    LoginTextField(
                      hintText: 'Password',
                      validator: LoginPageHelper.validatePassword,
                      onSaved: (value) => _password = value!,
                      obscureText: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'Forgot Password?',
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    LoginButton(
                        text: _isLogin ? 'Sign in' : 'Sign up',
                        onTap: () async => await onLoginOrRegister()),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            'Or continue with',
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 1.5,
                          color: Colors.grey[400],
                        )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SquareTile(
                          imagePath: 'assets/images/google.png',
                          onTap: () async {
                            try {
                             await ref
                                .read(authControllerProvider)                                
                                .googleSignIn(); 
                            } catch (e) {
                              print("from google: ${e.toString()}");
                            }
                             
                            
                          },
                        ),
                        const SquareTile(imagePath: 'assets/images/apple.png'),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _isLogin
                              ? "Not a member?"
                              : "Already have an account?",
                          style:
                              TextStyle(color: Colors.grey[700], fontSize: 18),
                        ),
                        TextButton(
                          onPressed: changeToRegister,
                          child: Text(
                            _isLogin ? "Register now" : "Login now",
                            style: const TextStyle(
                                fontSize: 18,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
