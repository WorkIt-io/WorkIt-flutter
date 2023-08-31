import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:workit/providers/business.dart';
import 'package:workit/providers/user_location_notifier.dart';
import 'package:workit/screens/businesses_detail_screen.dart';
import 'package:workit/utils/haversine_formula.dart';

import '../../../common/loader.dart';
import '../../../common/text_icon.dart';
import '../../../models/business.dart';

class BusinessRow extends ConsumerWidget {
  const BusinessRow(this.businesses, {required this.showDistance, super.key});


  final bool showDistance;
  final List<BusinessModel> businesses;  

  String? getDistance(LatLng businessLatLng, LatLng myLatLng, WidgetRef ref)
  {
    final double distance = HaversineFormula.haversineDistance(myLatLng.latitude, myLatLng.longitude, businessLatLng.latitude, businessLatLng.longitude);
    return distance.ceil().toString();
  }   

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final LatLng? myLoc = ref.watch(userLocationNotifierProvider);

    return SizedBox(
      height: 250,
      child: ListView.builder(        
        scrollDirection: Axis.horizontal,
        itemCount: businesses.length,
        itemBuilder: (context, index) {
          var theme = Theme.of(context);
          return GestureDetector(
            onTap: () {
              selectedBusiness = businesses[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      BusinessDeatilScreen(business: businesses[index]),
                ),

              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 250,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  businesses[index].images.isEmpty ?
                  Image.asset("assets/images/workit_logo_no_bg.png",
                    fit: BoxFit.fill,                    
                    height: 100,
                    width: double.infinity,
                  ) 
                  :
                  CachedNetworkImage(
                    imageUrl: businesses[index].images.first,
                    placeholder: (context, url) => Image.asset("assets/images/workit_logo_no_bg.png"),
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
                          businesses[index].name,
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
                          businesses[index].description,
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
                      children: [
                        TextIcon(
                          text: businesses[index].rate.toString(),
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
                            )),
                        if(showDistance) myLoc == null ? const SizedBox(height: 20, width:20, child: CircularProgressIndicator()) : Text("${getDistance(businesses[index].location, myLoc ,ref) ?? 2} km"),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.only(
                              right: 5, top: 5, bottom: 5, left: 5),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(10),
                                right: Radius.circular(10)),
                            color: Colors.blueAccent,
                          ),
                          child: TextIcon(
                            text: businesses[index].price.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                            icon: const Icon(
                              Icons.attach_money,
                              color: Colors.white,
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
        },
      ),
    );
  }
}
