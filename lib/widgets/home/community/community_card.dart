import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workit/models/community.dart';
import 'package:workit/providers/community/community_id.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/screens/community/community_detail_screen.dart';
import 'package:workit/utils/date_parser.dart';
import 'package:workit/utils/haversine_formula.dart';

class CommunityCard extends ConsumerStatefulWidget {
  const CommunityCard(this.community, {super.key, this.addShadow = false});

  final Community community;
  final bool addShadow;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommunityCardState();
}

class _CommunityCardState extends ConsumerState<CommunityCard> {
  String? getDistance(LatLng communityLatLng, LatLng? myLatLng, WidgetRef ref) {
    if (myLatLng == null) return 'No Location';

    final double distance = HaversineFormula.haversineDistance(
        myLatLng.latitude,
        myLatLng.longitude,
        communityLatLng.latitude,
        communityLatLng.longitude);
    return distance.ceil().toString();
  }

  @override
  Widget build(BuildContext context) {
    LatLng? myLoc = ref.watch(userLocationNotifierProvider);
    bool isLoading = ref.watch(userLocationNotifierProvider.notifier).isLoading;
    var theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ref.read(communityIdProvider.notifier).state = widget.community.id;

        // push to community detail screen.
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CommunityDetailScreen(
              community: widget.community,
            ),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 300,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          boxShadow: widget.addShadow ? [const BoxShadow(blurRadius: 4, spreadRadius: 1.5, offset: Offset(3, 3))] : null,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.community.images.isEmpty
                ? Image.asset(
                    "assets/images/workit_logo_no_bg.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: double.infinity,
                  )
                : CachedNetworkImage(
                    imageUrl: widget.community.images.first,
                    placeholder: (context, url) =>
                        Image.asset("assets/images/workit_logo_no_bg.png"),
                    fit: BoxFit.fill,
                    height: 100,
                    width: double.infinity,
                  ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.community.name,
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.community.description,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: theme.colorScheme.secondary, fontSize: 18),
                  )
                ],
              ),
            ),
            const Spacer(),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 8, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    formatToCommunityRow(widget.community.date),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 25,
                      color: Colors.black,
                    ),
                  ),
                  if (isLoading)
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  const Spacer(),
                  if (!isLoading)
                    Text(
                      "${getDistance(widget.community.location, myLoc, ref) ?? 2} km",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  const SizedBox(
                    width: 5,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
