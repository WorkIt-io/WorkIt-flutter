import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/controller/auth_controller.dart';
import 'package:workit/screens/home_screen.dart';
import 'package:workit/screens/login_page.dart';
import 'package:workit/screens/verify_email_screen.dart';
import 'package:workit/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: CurrentTheme().themeData,
      home: const UserAuthStream(),
    );
  }
}

class UserAuthStream extends ConsumerWidget {
  const UserAuthStream({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(userStreamAuthProvider).when(
          data: (user) {
            if (user != null) // user Sign Up already.
            {
              return user.emailVerified
                  ? const HomeScreen()
                  : const EmailVerificationPage();
            } else // user never Sign Up.
            {
              return const LoginPage();
            }
          },
          error: (error, stackTrace) => const Scaffold(),
          loading: () => const CircularProgressIndicator(),
        );
  }
}
