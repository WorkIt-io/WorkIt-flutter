import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workit/common/text_icon.dart';
import 'package:workit/constant/colors.dart';
import 'package:workit/models/business.dart';
import 'package:workit/providers/business/business_id.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/screens/business/businesses_detail_screen.dart';
import 'package:workit/utils/haversine_formula.dart';

class BusinessCard extends ConsumerWidget {
  const BusinessCard(this.business, {super.key, this.addShadow = false});

  final BusinessModel business;
  final bool addShadow;

  String? getDistance(LatLng businessLatLng, LatLng? myLatLng, WidgetRef ref) {
    if (myLatLng == null) return 'No Location';

    final double distance = HaversineFormula.haversineDistance(
        myLatLng.latitude,
        myLatLng.longitude,
        businessLatLng.latitude,
        businessLatLng.longitude);
    return distance.ceil().toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LatLng? myLoc = ref.watch(userLocationNotifierProvider);
    bool isLoading = ref.watch(userLocationNotifierProvider.notifier).isLoading;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        ref.read(businessIdProvider.notifier).state = business.id;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BusinessDeatilScreen(business: business),
          ),
        );
      },
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 270,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          boxShadow: addShadow
              ? [
                  const BoxShadow(
                      blurRadius: 4, spreadRadius: 1.5, offset: Offset(3, 3))
                ]
              : null,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            business.images.isEmpty
                ? Image.asset(
                    "assets/images/workit_logo_no_bg.png",
                    fit: BoxFit.fill,
                    height: 100,
                    width: double.infinity,
                  )
                : CachedNetworkImage(
                    imageUrl: business.images.first,
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
                    business.name,
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
                    business.description,
                    maxLines: 2,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: theme.colorScheme.secondary, fontSize: 18),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 8, 10),
              child: Row(
                children: [
                  TextIcon(
                    text: business.rate.toString(),
                    spacing: 1,
                    icon: const Icon(
                      Icons.star,
                      color: Colors.yellow,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                    child: VerticalDivider(
                      width: 20,
                      color: Colors.black,
                    ),
                  ),
                  if (isLoading)
                    const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(),
                    ),
                  if (!isLoading)
                    Text(
                        "${getDistance(business.location, myLoc, ref) ?? 2} km"),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.only(
                        right: 5, top: 5, bottom: 5, left: 5),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(10),
                          right: Radius.circular(10)),
                      color: Color(0xffffd7be),
                    ),
                    child: TextIcon(
                      text: business.price.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                      icon: const Icon(
                        Icons.attach_money,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
