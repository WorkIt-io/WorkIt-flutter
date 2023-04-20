import 'package:flutter/material.dart';

import '../providers/businesses.dart';
import '../widgets/business_tile.dart';

class CommunitiesFeed extends StatefulWidget {
  const CommunitiesFeed({super.key});

  static const String routeName = "/communities-feed";

  @override
  State<CommunitiesFeed> createState() => CommunitiesFeedState();
}

class CommunitiesFeedState extends State<CommunitiesFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WorkIt'),
      ),
      body: ListView.builder(
        itemCount: Businesses().businessesList.length,
        itemBuilder: (context, index) =>
            BusinessTile(Businesses().businessesList[index]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
      ),
    );
  }
}
