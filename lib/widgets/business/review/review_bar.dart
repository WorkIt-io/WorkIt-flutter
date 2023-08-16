import 'package:flutter/material.dart';

class ReviewBar extends StatelessWidget {
  const ReviewBar({super.key, required this.fill, required this.rate});

  final double fill;
  final int rate;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          width: 180,
          clipBehavior: Clip.hardEdge,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[400],
          ),
          child: FractionallySizedBox(
            alignment: Alignment.bottomLeft,
            widthFactor: fill,
            child: Container(color: Colors.yellow),
          ),
        ),
        const SizedBox(width: 10),
        Text(rate.toString()),
      ],
    );
  }
}