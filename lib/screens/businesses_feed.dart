import 'package:flutter/material.dart';

import '../providers/businesses.dart';
import '../widgets/business_tile.dart';

class BusinessesFeed extends StatefulWidget {
  const BusinessesFeed({super.key});  

  @override
  State<BusinessesFeed> createState() => BusinessesFeedState();
}

class BusinessesFeedState extends State<BusinessesFeed> {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      body: ListView.builder(
        itemCount: Businesses().businessesList.length,
        itemBuilder: (context, index) =>
            BusinessTile(Businesses().businessesList[index]),
      ),      
    );
  }
}
