import 'package:flutter/material.dart';
import 'package:workit/models/business.dart';

import '../../models/review.dart';

class ReviewsBusiness extends StatefulWidget {
  const ReviewsBusiness({
    super.key,
    required this.business,
  });

  final Business business;

  @override
  State<ReviewsBusiness> createState() => _ReviewsBusinessState();
}

class _ReviewsBusinessState extends State<ReviewsBusiness> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.only(top: 20),
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        border: Border.all(width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [          
          Text.rich(
            TextSpan(
              text: widget.business.rate.toString(),
              style: theme.textTheme.headlineMedium,
              children: const [
                WidgetSpan(
                  child: Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 40,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [


            ],
          )
        ],
      ),
    );
  }
}

class ReviewBar extends StatefulWidget {
  const ReviewBar({super.key, required this.review});

  final Review review;

  @override
  State<ReviewBar> createState() => _ReviewBarState();
}

class _ReviewBarState extends State<ReviewBar> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
