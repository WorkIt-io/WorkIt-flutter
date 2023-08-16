import 'package:flutter/material.dart';
import 'package:workit/widgets/business/business_images.dart';
import 'package:workit/widgets/business/review/reviews_business.dart';

import '../models/business.dart';
import '../widgets/business/location_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Images",
              style: theme.textTheme.displaySmall!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const BusinessImages(),
            const SizedBox(height: 20),
            Text(
              "Location",
              style: theme.textTheme.displaySmall!.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
            const LocationWidget(),
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
