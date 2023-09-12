import 'package:flutter/material.dart';
import 'package:workit/screens/business/add_business_screen.dart';
import 'package:workit/screens/feeds/businesses_feed.dart';
import 'package:workit/screens/feeds/communities_feed.dart';
import 'package:workit/screens/feeds/search_feed.dart';
import 'package:workit/widgets/home/core/drawer_home_page.dart';
import 'package:workit/widgets/home/core/navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  final feeds = const [BusinessesFeed(), SearchFeed(), CommunitiesFeed()];

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('WorkIt'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const AddBusinessScreen(),
                  )),
              icon: const Icon(
                Icons.add_business,
                size: 30,
              ))
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
