import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/categories.dart';
import 'package:workit/constant/home_images.dart';
import 'package:workit/providers/business/businesses_notifier.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/widgets/home/business/business_row.dart';
import 'package:workit/widgets/home/core/page_view_images_home.dart';
import 'package:workit/widgets/home/core/category_row.dart';
import 'package:workit/widgets/home/core/title_row.dart';

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

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: SizedBox(
                height: 210, child: PageViewImagesHome(images: businessImages, description: businessTextDescription, title: businessTextImages,)),
          ),
          const SizedBox(height: 10),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Near By"),
          ),
          BusinessRow(
            businesses,
          ),
          const SizedBox(height: 20),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Categories", seeAll: false,),
          ),
          const CategoryRow(businessCategories),
          const SizedBox(height: 20),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Best Rate"),
          ),
          BusinessRow(
            businesses.reversed.toList(),
          ),
          const SizedBox(height: 20),
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Your Favorite"),
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
