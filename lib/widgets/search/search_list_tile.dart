import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/loader.dart';
import 'package:workit/models/business.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/business/business_id.dart';
import 'package:workit/providers/community/community_id.dart';
import 'package:workit/providers/search_notifier.dart';
import 'package:workit/screens/business/businesses_detail_screen.dart';
import 'package:workit/screens/community/community_detail_screen.dart';

class SearchListTile extends ConsumerWidget {
  const SearchListTile(this.tile, {super.key});

  final Object tile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final BusinessModel? businessRes =
        tile is BusinessModel ? tile as BusinessModel : null;
    final Community? communityRes =
        tile is Community ? tile as Community : null;

    return InkWell(
      onTap: () async {


        if (businessRes != null) {
          ref.read(businessIdProvider.notifier).state = businessRes.id;
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  BusinessDeatilScreen(business: businessRes)));
        } else {
          ref.read(communityIdProvider.notifier).state = communityRes!.id;
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  CommunityDetailScreen(community: communityRes)));
        }

        ref.read(searchNotifierProvider.notifier).reset();
        ref.read(isSelectingProvider.notifier).state = false;
      },
      child: ListTile(
        title:
            Text(businessRes != null ? businessRes.name : communityRes!.name),
        subtitle: Text(
            businessRes != null ? businessRes.address : communityRes!.address),
        leading: businessRes != null
            ? businessRes.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: businessRes.images[0],
                    placeholder: (context, url) => const Loader(),
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                  )
                : Image.asset(
                    'assets/images/workit_logo_no_bg.png',
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                  )
            : communityRes!.images.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: communityRes.images[0],
                    placeholder: (context, url) => const Loader(),
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                  )
                : Image.asset(
                    'assets/images/workit_logo_no_bg.png',
                    fit: BoxFit.fill,
                    height: 60,
                    width: 60,
                  ),
        trailing: const Icon(Icons.arrow_right_alt_rounded),
      ),
    );
  }
}
