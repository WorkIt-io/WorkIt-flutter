import 'package:flutter/material.dart';
import 'package:workit/widgets/business/business_images.dart';
import 'package:workit/widgets/business/reviews_business.dart';

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
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 20),
          child: Column(  
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BusinessImages(business: widget.business),
              const LocationWidget(),
              ReviewsBusiness(business: widget.business,),
            ],
          ),
        ),
      ),
    );
  }
}
