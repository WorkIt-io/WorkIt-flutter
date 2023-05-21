import 'package:flutter/material.dart';
import 'package:workit/screens/businesses_feed.dart';
import 'package:workit/screens/communities_feed.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final feeds = const [BusinessesFeed(), CommunitiesFeed()];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentFeedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WorkIt'),
      ),
      body: IndexedStack(
        index: currentFeedIndex,
        children: widget.feeds,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentFeedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Communities',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentFeedIndex = index;
          });
        },
      ),
    );
  }
}
