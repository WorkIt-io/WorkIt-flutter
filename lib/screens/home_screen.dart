import 'package:flutter/material.dart';
import 'package:workit/screens/add_business_screen.dart';

import 'package:workit/screens/feeds/businesses_feed.dart';
import 'package:workit/screens/feeds/communities_feed.dart';

import '../widgets/home/navigation_bar.dart';
import '../widgets/home/drawer_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final feeds = const [BusinessesFeed(), CommunitiesFeed()];

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentFeedIndex = 0;

  void onSelectItem(int navigationBarIndex) {
    setState(() {
      currentFeedIndex = navigationBarIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerHomePage(),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('WorkIt'),
        backgroundColor: Colors.blueGrey[100],
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddBusinessScreen(),
                  )),
              icon: const Icon(Icons.add_business,size: 30,))
        ],
      ),
      body: IndexedStack(
        index: currentFeedIndex,
        children: widget.feeds,
      ),
      bottomNavigationBar: CustomNavigationBar(onSelectItem: onSelectItem),
    );
  }
}
