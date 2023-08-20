import 'package:flutter/material.dart';

import 'package:workit/screens/feeds/businesses_feed.dart';
import 'package:workit/screens/feeds/communities_feed.dart';


import '../widgets/home/navigation_bar.dart';
import '../widgets/home/drawer_home_page.dart';
import '../widgets/home/search_bar.dart';

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
      appBar: AppBar(
        title: const Text('WorkIt'),
        actions: [
          IconButton(
              onPressed: () => showSearch(
                    context: context,
                    delegate: CustomSearchDelegate(),
                  ),
              icon: const Icon(Icons.search))
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

