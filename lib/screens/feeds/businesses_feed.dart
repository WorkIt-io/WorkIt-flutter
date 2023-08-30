import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/providers/businesses_notifier.dart';
import 'package:workit/widgets/home/business/business_row.dart';

import '../../models/business.dart';
import '../../widgets/home/search_text_filed.dart';

class BusinessesFeed extends ConsumerStatefulWidget {
  const BusinessesFeed({super.key});

  @override
  ConsumerState<BusinessesFeed> createState() => BusinessesFeedState();
}

class BusinessesFeedState extends ConsumerState<BusinessesFeed> {
  bool showDistance = false;


  @override
  void initState() {
    super.initState();
    if(ref.read(businessesStateNotifierProvider).isEmpty) {
      ref.read(businessesStateNotifierProvider.notifier).getAllBusinessFromDatabase();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<BusinessModel> businesses = ref.watch(businessesStateNotifierProvider); 
       
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
          BusinessRow(
            businesses,
            showDistance: showDistance,
          ),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Text("Your Favorite",
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          BusinessRow(
            businesses,
            showDistance: showDistance,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => showDistance = true,
                  child: const Text("get Location")),
            ],
          ),
        ],
      ),
    );
  }
}
