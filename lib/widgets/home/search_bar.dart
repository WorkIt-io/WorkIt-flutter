import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {    

  List<String> searchList = [
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

    for (String item in searchList) {
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
    for (String item in searchList) {
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