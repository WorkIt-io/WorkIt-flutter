import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/community.dart';
import 'package:workit/widgets/home/community/community_card.dart';

class CommunityRow extends ConsumerWidget {
  const CommunityRow(this.communities, {super.key});

  final List<Community> communities;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: communities.length,
        itemBuilder: (context, index) {          
          return CommunityCard(communities[index]);
        },
      ),
    );
  }
}
