import 'package:flutter/material.dart';
import '../constant/dummy_data.dart';
import '../providers/business.dart';
import '../widgets/business/business_tile.dart';

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
          itemBuilder: (context, index) {
            selectedBusiness = Businesses().businessesList[index];
            return BusinessTile(selectedBusiness!);
          }),
    );
  }
}
