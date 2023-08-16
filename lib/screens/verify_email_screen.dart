import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workit/constant/firebase_instance.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  EmailVerificationPageState createState() => EmailVerificationPageState();
}

class EmailVerificationPageState extends State<EmailVerificationPage>
    with SingleTickerProviderStateMixin {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late AnimationController _animationController;
  late Animation<int> _animation;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..addListener(() {
            if (_animationController.isCompleted) {
              setState(() {
                _canResend = true;
              });
            }
          });

    _animation = IntTween(begin: 10, end: 0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  void _sendVerificationEmail() async {
    User? currentUser = _auth.currentUser;
    if (currentUser != null && !currentUser.emailVerified) {
      await currentUser.sendEmailVerification();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Email Verification", style: TextStyle(fontSize: 24),)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Icon(
              Icons.mark_email_unread_sharp,
              size: 100,
            ),
            const SizedBox(height: 40),
            Text(
              'Verify your email address',
              style: theme.textTheme.headlineLarge!.copyWith(color: theme.colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              "We've sent a verification email to your provided address. Please check your inbox and click on the verification link to verify your email and continue.",
              style: theme.textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            if (_canResend)
              ElevatedButton(
                onPressed: _sendVerificationEmail,
                child: Text("Resend Verification Email", style: theme.textTheme.labelLarge!.copyWith(fontSize: 22, color: theme.colorScheme.secondary),),
              )
            else
              Text(
                "You can resend the email in ${_animation.value} seconds",
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary),
              ),
            const SizedBox(height: 30),
            TextButton.icon(
              icon: const Icon(Icons.arrow_circle_left_outlined),
              onPressed: () async {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //   builder: (context) => const LoginPage(),
                // ));
                await firebaseInstance.signOut();
              },
              label: Text("Back to Login", style: theme.textTheme.headlineSmall!.copyWith(color: theme.colorScheme.secondary)),
            ),
          ],
        ),
      ),
    );
  }
}
