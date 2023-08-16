import 'package:flutter/material.dart';
import 'package:workit/constant/firebase_instance.dart';
import 'package:workit/screens/home_screen.dart';
import 'package:workit/screens/login_page.dart';
import 'package:workit/screens/verify_email_screen.dart';

class StreamAuth extends StatelessWidget {
  const StreamAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firebaseInstance.authStateChanges(),
      builder: (context, snapshot) {              
        if (snapshot.hasData && (snapshot.data!.emailVerified)) {
          return const HomeScreen();
        } else if (snapshot.hasData && snapshot.data!.emailVerified == false) {
          return const EmailVerificationPage();
        }
        return const LoginPage();
      },
    );
  }
}
