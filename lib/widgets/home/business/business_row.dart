import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/business.dart';
import 'package:workit/widgets/home/business/business_card.dart';

class BusinessRow extends ConsumerWidget {
  const BusinessRow(this.businesses, {super.key});
  
  final List<BusinessModel> businesses;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: businesses.length,
        itemBuilder: (context, index) {          
          return BusinessCard(businesses[index]);
        },
      ),
    );
  }
}
