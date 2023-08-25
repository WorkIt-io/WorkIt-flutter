import 'package:flutter/material.dart';
import 'package:workit/widgets/home/business/business_row.dart';

import '../../constant/dummy_data.dart';
import '../../widgets/home/search_text_filed.dart';

class BusinessesFeed extends StatefulWidget {
  const BusinessesFeed({super.key});

  @override
  State<BusinessesFeed> createState() => BusinessesFeedState();
}

class BusinessesFeedState extends State<BusinessesFeed> {
  bool showDistance = false;

  @override
  Widget build(BuildContext context) {
    final bussines = Businesses().businessesList;
    var theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const SearchTextFiled(),
          const SizedBox(height: 10),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),            
            child: Text("Best Rate",
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          BusinessRow(bussines.reversed.toList(), showDistance: showDistance,),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Text("Your Favorite",
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          BusinessRow(bussines
              .where((element) => int.parse(element.id) % 2 == 0)
              .toList(), showDistance: showDistance,),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () => showDistance= true, child: const Text("get Location")),
            ],
          ),
        ],
      ),
    );
  }
}
