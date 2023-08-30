import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/text_icon.dart';
import 'package:workit/providers/review_notifier.dart';
import 'package:workit/widgets/business/review/comments_list.dart';

import './review_dialog.dart';
import '../../../models/review.dart';
import '../../../utils/review_widget_helper.dart';
import 'review_bar.dart';

class ReviewsBusiness extends ConsumerStatefulWidget {
  const ReviewsBusiness({
    super.key,
  });

  @override
  ConsumerState<ReviewsBusiness> createState() => _ReviewsBusinessState();
}

class _ReviewsBusinessState extends ConsumerState<ReviewsBusiness> {
  @override
  void initState() {
    super.initState();
    ref.read(reviewStateNotifierProvider.notifier).getAllReviews();
  }

  Future<void> showReviewDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => const ReviewDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    List<Review> reviews = ref.watch(reviewStateNotifierProvider);
    List<double> ratePerReview = ReviewWidgetHelper.calcRatePerReview(reviews);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        margin: const EdgeInsets.only(top: 20),
        width: 400,
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: theme.colorScheme.surface,
            border: Border.all(width: 1)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextIcon(
                            text: ReviewWidgetHelper.calcAvgRate(reviews)
                                .toString(),
                            icon: const Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 45,
                            ),
                            style: theme.textTheme.headlineLarge),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () => showReviewDialog(),
                          icon: Icon(
                            Icons.message,
                            size: 40,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        TextButton(
                          onPressed: () => showReviewDialog(),
                          child: Text("Add Review",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.colorScheme.onSurface)),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    ...List.generate(
                      5,
                      (index) => ReviewBar(
                          rate: index + 1,
                          fill: reviews.isEmpty
                              ? 0
                              : (ratePerReview[index] / reviews.length)),
                    ),
                  ],
                ),
              ],
            ),
            if (reviews.isEmpty)
              Text(
                "No Comments Yet",
                style: theme.textTheme.headlineSmall!
                    .copyWith(color: theme.colorScheme.primary),
              ),
            if (reviews.isNotEmpty) const CommentsList(),
          ],
        ));
  }
}
