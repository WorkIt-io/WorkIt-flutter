import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/providers/business/businesses_notifier.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/widgets/home/business/business_row.dart';
import 'package:workit/widgets/home/business/page_view_images_home.dart';

import '../../models/business.dart';

class BusinessesFeed extends ConsumerStatefulWidget {
  const BusinessesFeed({super.key});

  @override
  ConsumerState<BusinessesFeed> createState() => BusinessesFeedState();
}

class BusinessesFeedState extends ConsumerState<BusinessesFeed> {  
  @override
  void initState() {
    super.initState();
    if (ref.read(businessesStateNotifierProvider).isEmpty) {
      ref
          .read(businessesStateNotifierProvider.notifier)
          .getAllBusinessFromDatabase();
    }

    ref.read(userLocationNotifierProvider.notifier).getCurrentLocation();
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
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: SizedBox(height: 200, child: PageViewImagesHome()),
          ),
          const SizedBox(height: 10),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Near By",
                    style: theme.textTheme.headlineMedium!.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    children: [
                      Text(
                        "See All",
                        style: TextStyle(fontSize: 20),
                      ),
                      Icon(
                        Icons.arrow_right,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BusinessRow(
            businesses,            
          ),
          const SizedBox(height: 20),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
            child: Text("Best Rate",
                style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold)),
          ),
          BusinessRow(
            businesses.reversed.toList(),            
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
          ),
          const SizedBox(height: 10),                    
        ],
      ),
    );
  }
}
