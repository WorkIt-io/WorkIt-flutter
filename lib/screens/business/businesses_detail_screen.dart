import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/business.dart';
import 'package:workit/widgets/business/detail/business_images.dart';
import 'package:workit/widgets/business/detail/location_section.dart';
import 'package:workit/widgets/business/detail/opening_times.dart';
import 'package:workit/widgets/business/detail/text_section.dart';
import 'package:workit/widgets/business/detail/whatsapp_button.dart';
import 'package:workit/widgets/business/review/reviews_business.dart';

class BusinessDeatilScreen extends ConsumerStatefulWidget {
  const BusinessDeatilScreen({super.key, required this.business});

  final BusinessModel business;

  @override
  ConsumerState<BusinessDeatilScreen> createState() =>
      _BusinessDeatilScreenState();
}

class _BusinessDeatilScreenState extends ConsumerState<BusinessDeatilScreen> {
  @override
  void initState() {
    super.initState();
  }

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
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BusinessImages(),
                const Divider(),

                // About Section
                TextSection(
                  "About",
                  widget.business.description,
                  theme,
                ),

                const Divider(),

                // Opening Times
                OpeningTimes(times, theme),
                const Divider(),

                LocationSection(widget.business.address, theme),
                const Divider(),

                const SizedBox(height: 20),
                Text(
                  "Reviews",
                  style: theme.textTheme.displaySmall!.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
                const ReviewsBusiness(),

                const SizedBox(height: 20),
                //const Divider(),
                //const SizedBox(height: 10),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 0.5)],
                shape: BoxShape.rectangle,
                color: Colors.white,
              ),
              child: WhatsAppButton(widget.business.phoneNumber),
            ),
          ),
        ],
      ),
    );
  }
}
