import 'package:flutter/material.dart';
import 'package:workit/providers/business.dart';
import 'package:workit/screens/businesses_detail_screen.dart';

import '../../../common/text_icon.dart';
import '../../../models/business.dart';

class BusinessRow extends StatelessWidget {
  const BusinessRow(this.bussines, {required this.showDistance, super.key});


  final bool showDistance;
  final List<Business> bussines;  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: bussines.length,
        itemBuilder: (context, index) {
          var theme = Theme.of(context);
          return GestureDetector(
            onTap: () {
              selectedBusiness = bussines[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      BusinessDeatilScreen(business: bussines[index]),
                ),

              );
            },
            child: Container(
              clipBehavior: Clip.hardEdge,
              width: 240,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    bussines[index].imageUrl,
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
                          bussines[index].name,
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
                          bussines[index].description,
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
                          text: bussines[index].rate.toString(),
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
                        Text("${bussines[index].distance} km"),
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
                            text: bussines[index].price.toString(),
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
