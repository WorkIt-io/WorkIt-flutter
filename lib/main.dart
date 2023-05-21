import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:workit/screens/home_screen.dart';
import 'package:workit/theme.dart';

import './providers/businesses.dart';
import './constant/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Businesses()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: CurrentTheme().themeData, 
        initialRoute: homeScreenName,
        routes: {
          homeScreenName: (context) => const HomeScreen(),
        },
      ),
    );
  }
}
