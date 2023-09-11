import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/categories.dart';
import 'package:workit/constant/home_images.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/community/communities_notifier.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/widgets/home/community/community_row.dart';
import 'package:workit/widgets/home/core/category_row.dart';
import 'package:workit/widgets/home/core/page_view_images_home.dart';
import 'package:workit/widgets/home/core/title_row.dart';

class CommunitiesFeed extends ConsumerStatefulWidget {
  const CommunitiesFeed({super.key});

  @override
  ConsumerState<CommunitiesFeed> createState() => CommunitiesFeedState();
}

class CommunitiesFeedState extends ConsumerState<CommunitiesFeed> {
  @override
  void initState() {
    super.initState();
    if (ref.read(communitiesStateNotifierProvider).isEmpty) {
      ref
          .read(communitiesStateNotifierProvider.notifier)
          .getAllCommunityFromDatabase();
    }

    ref.read(userLocationNotifierProvider.notifier).getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {    
    List<Community> communities = ref.watch(communitiesStateNotifierProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0),
            child: SizedBox(
                height: 210, child: PageViewImagesHome(images: communityImages, description: communityTextImages, title: communityTextDescription,)),
          ),
          const SizedBox(height: 10),
          const Divider(),                    
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Near By")
          ),
          CommunityRow(
            communities,
          ),
          const SizedBox(height: 20),
          const Divider(),
           const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Categories", seeAll: false,)
          ),
          const CategoryRow(communityCategories),          
          const Divider(),          
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 0, 16),
            child: TitleRow(title: "Most Popular")
          ),
          CommunityRow(
            communities,
          ),          
          const Divider(),          
        ],
      ),
    );
  }
}
