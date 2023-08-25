import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class OpeningTimes extends StatefulWidget {
  final Map<String, String> openingHours;
  final ThemeData theme;

  const OpeningTimes(this.openingHours, this.theme, {super.key});

  @override
  State<OpeningTimes> createState() => _OpeningTimesState();
}

class _OpeningTimesState extends State<OpeningTimes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Opening Times",
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: widget.openingHours.entries.map((day) {
              return Row(
                children: [
                  Text(
                    "${day.key}: ",
                    style: TextStyle(
                      color: widget.theme.colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    day.value,
                    style: TextStyle(
                      color: widget.theme.colorScheme.primary,
                      fontSize: 16,
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
