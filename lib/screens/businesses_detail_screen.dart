import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:workit/widgets/business/business_images.dart';

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
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(widget.business.name),
      ),
      body: const BusinessImages(),
    );
  }
}
