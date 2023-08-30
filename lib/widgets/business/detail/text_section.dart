import 'package:flutter/material.dart';

class TextSection extends StatefulWidget {
  final String title;
  final String text;
  final ThemeData theme;

  const TextSection(this.title, this.text, this.theme, {super.key});

  @override
  State<TextSection> createState() => _TextSectionState();
}

class _TextSectionState extends State<TextSection> {
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
            widget.title,
            style: TextStyle(
              color: widget.theme.colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.text,
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
