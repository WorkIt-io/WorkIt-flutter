import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(
      {super.key, required this.text, this.style, required this.icon});

  final String text;
  final TextStyle? style;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Text.rich(      
      TextSpan(        
        text: text,
        style: style ?? Theme.of(context).textTheme.titleLarge,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.top,
            child: icon,
          ),
        ],
      ),
    );
  }
}
