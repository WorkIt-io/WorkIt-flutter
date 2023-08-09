import 'package:flutter/material.dart';
import 'package:workit/constant/firebase_instance.dart';
import 'package:workit/screens/home_screen.dart';
import 'package:workit/screens/login_page.dart';

class StreamAuth extends StatelessWidget {
  const StreamAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseInstance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
