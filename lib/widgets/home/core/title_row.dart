import 'package:flutter/material.dart';

class TitleRow extends StatelessWidget {
  const TitleRow({super.key, required this.title, this.seeAll = true});

  final String title;
  final bool seeAll;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: theme.textTheme.headlineMedium!.copyWith(
                color: theme.colorScheme.primary.withOpacity(0.85), fontWeight: FontWeight.w600)),
        if (seeAll)        
          TextButton(
            onPressed: () {},
            child: 
            const Row(
              children: [
                Text(
                  "See All",
                  style: TextStyle(fontSize: 20),
                ),
                Icon(
                  Icons.arrow_right,
                  size: 30,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
