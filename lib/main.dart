import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/communities_feed.dart';
import './screens/businesses_feed.dart';
import './providers/businesses.dart';

void main() {
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
        title: 'WorkIt',
        home: BusinessesFeed(),
        routes: {
          CommunitiesFeed.routeName: (context) => CommunitiesFeed(),
        },
      ),
    );
  }
}
