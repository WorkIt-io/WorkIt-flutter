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

class CustomSearchDelegate extends SearchDelegate {    

  List<String> SearchList = [
    'ProFit',
    'IClimb',
    'Yoga',
    'Basketball',
    'Acro',
    'Gym',
    'Baseball',
    'Football',
    'CrossFit',
  ];
  

  @override
  List<Widget>? buildActions(BuildContext context) {    
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_outlined));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Text('');
    }

    List<String> matchList = [];

    for (String item in SearchList) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchList.add(item);
      }
    }

    if (matchList.isNotEmpty) {
      return ListView.builder(
        itemCount: matchList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(matchList[index]),
          onTap: () {query = matchList[index];},
        ),
      );
    } else {
      return ListTile(
        title: const Text('No result found'),
        onTap: () {},
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchList = [];
    for (String item in SearchList) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        matchList.add(item);
      }
    }    

    return ListView.builder(
        itemCount: matchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(matchList[index]),
            onTap: () {                               
              query = matchList[index];                              
            },
          );
        });
  }
}
