import 'package:flutter/material.dart';
import 'package:workit/widgets/business/business_images.dart';
import 'package:workit/widgets/business/location_section.dart';
import 'package:workit/widgets/business/opening_times.dart';
import 'package:workit/widgets/business/review/reviews_business.dart';
import 'package:workit/widgets/business/text_section.dart';
import 'package:workit/widgets/business/map_widget.dart';

import '../models/business.dart';

class BusinessDeatilScreen extends StatefulWidget {
  const BusinessDeatilScreen({super.key, required this.business});

  final Business business;

  @override
  State<BusinessDeatilScreen> createState() => _BusinessDeatilScreenState();
}

class _BusinessDeatilScreenState extends State<BusinessDeatilScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Map<String, String> times = {
      "Sunday": "7 am - 10 pm",
      "Monday": "9 am - 9 pm",
      "Tuesday": "7 am - 10 pm",
      "Wednesday": "9 am - 9 pm",
      "Thursday": "9 am - 9 pm",
      "Friday": "9 am - 9 pm",
      "Saturday": "9 am - 9 pm"
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const BusinessImages(),
            const Divider(),

            // About Section
            TextSection(
              "About",
              "some description about the place.\nThis should be fetched from the DB",
              theme,
            ),
            const Divider(),

            // Opening Times
            OpeningTimes(times, theme),
            const Divider(),

            LocationSection("Some address 123, Tel Aviv", theme),
            const Divider(),

            const SizedBox(height: 20),
            Text(
              "Reviews",
              style: theme.textTheme.displaySmall!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const ReviewsBusiness(),
          ],
        ),
      ),
    );
  }
}
