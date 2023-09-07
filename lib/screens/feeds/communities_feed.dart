import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/community/communities_notifier.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/widgets/home/community/community_row.dart';

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
    var theme = Theme.of(context);
    List<Community> communities = ref.watch(communitiesStateNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
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
        CommunityRow(
          communities,
        ),
        const SizedBox(height: 20),
        const Divider(),
      ],
    );
  }
}
