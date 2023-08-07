import 'package:flutter/material.dart';
import 'package:workit/models/community.dart';
import '../constant/dummy_data.dart';

class CommunitiesFeed extends StatefulWidget {
  const CommunitiesFeed({super.key});

  @override
  State<CommunitiesFeed> createState() => CommunitiesFeedState();
}

class CommunitiesFeedState extends State<CommunitiesFeed> {
  List<Community> commList = Communities().communitiesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: ListView.builder(        
        itemCount: commList.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Card(
              child: ListTile(
                title: Text(commList[index].name),
                subtitle: Text(commList[index].description),
                leading: Image.network(
                  height: 60,
                  width: 60,
                  commList[index].imageUrl,
                  fit: BoxFit.scaleDown,
                ),
                trailing: const Icon(Icons.arrow_right_outlined, size: 30,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
