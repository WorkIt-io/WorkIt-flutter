import 'package:flutter/material.dart';
import 'package:workit/screens/home_screen.dart';
import 'package:workit/theme.dart';
import './constant/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(      
      theme: CurrentTheme().themeData, 
      initialRoute: homeScreenName,
      routes: {
        homeScreenName: (context) => const HomeScreen(),
      },
    );
  }
}
