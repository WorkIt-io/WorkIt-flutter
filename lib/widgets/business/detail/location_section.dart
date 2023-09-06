import 'package:flutter/material.dart';

import 'map_widget.dart';

class LocationSection extends StatefulWidget {
  final String address;
  final ThemeData theme;

  const LocationSection(this.address, this.theme, {super.key});

  @override
  State<LocationSection> createState() => _LocationSectionState();
}

class _LocationSectionState extends State<LocationSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Location",
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          const MapWidget(),
          const SizedBox(height: 10),
          Text(
            widget.address,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
