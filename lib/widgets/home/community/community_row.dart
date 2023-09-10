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

class CommunityRow extends ConsumerWidget {
  const CommunityRow(this.communities, {super.key});

  final List<Community> communities;

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
  Widget build(BuildContext context, WidgetRef ref) {
    LatLng? myLoc = ref.watch(userLocationNotifierProvider);
    bool isLoading = ref.watch(userLocationNotifierProvider.notifier).isLoading;

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: communities.length,
        itemBuilder: (context, index) {
          var theme = Theme.of(context);
          return GestureDetector(
            onTap: () {
              // change community Id Provider to communities[index].id
              ref.read(communityIdProvider.notifier).state =
                  communities[index].id;

              // push to community detail screen.
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CommunityDetailScreen(
                    community: communities[index],
                  ),
                ),
              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 300,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  communities[index].images.isEmpty
                      ? Image.asset(
                          "assets/images/workit_logo_no_bg.png",
                          fit: BoxFit.fill,
                          height: 100,
                          width: double.infinity,
                        )
                      : CachedNetworkImage(
                          imageUrl: communities[index].images.first,
                          placeholder: (context, url) => Image.asset(
                              "assets/images/workit_logo_no_bg.png"),
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
                          communities[index].name,
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
                          communities[index].description,
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
                          formatToCommunityRow(communities[index].date),
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
                            "${getDistance(communities[index].location, myLoc, ref) ?? 2} km",
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
        },
      ),
    );
  }
}
