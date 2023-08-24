import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon(
      {super.key, required this.text, this.style, required this.icon, this.alignIcon = PlaceholderAlignment.top});

  final String text;
  final TextStyle? style;
  final Icon icon;
  final PlaceholderAlignment alignIcon;    

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(                
        text: text,
        style: style ?? Theme.of(context).textTheme.titleLarge,
        children: [
          WidgetSpan(            
            alignment: alignIcon,
            child: icon,
          ),
        ],
      ),
    );
  }
}
