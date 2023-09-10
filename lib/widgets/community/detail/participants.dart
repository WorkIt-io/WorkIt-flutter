import 'package:flutter/material.dart';
import 'package:workit/models/community.dart';
import 'package:intl/intl.dart';

class Participants extends StatefulWidget {
  final Community community;
  final ThemeData theme;

  const Participants(this.community, this.theme, {super.key});

  @override
  State<Participants> createState() => _ParticipantsState();
}

class _ParticipantsState extends State<Participants> {
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
            "When",
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('EEEE, MMMM d, HH:mm').format(widget.community.date),
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Participants: ${widget.community.min ?? '0'}",
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
