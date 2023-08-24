import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/firebase_instance.dart';
import 'package:workit/models/review.dart';
import 'package:workit/providers/review.dart';
import 'package:workit/widgets/business/review/review_dialog.dart';

class Comment extends ConsumerWidget {
  const Comment(this.review, {super.key});

  final Review review;

  void showEditReviewDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (context) => ReviewDialog(
          isUpdate: true,
          title: review.title,
          text: review.text,
          rate: review.rate),
    );
  }

  void onDismiss(WidgetRef ref)
  {
    ref.read(reviewProvider.notifier).deleteReview();
  }

  Widget _buildStars(int rate) {
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < rate ? Icons.star : Icons.star_border,
          color: Colors.yellow[700],
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var theme = Theme.of(context);

    Widget otherComments = Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.title,
              style: theme.textTheme.titleLarge!
                  .copyWith(fontSize: 24, color: theme.colorScheme.primary),
            ),
            const SizedBox(height: 10),
            Text(
              review.text,
              maxLines: 3,
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontSize: 16, color: theme.colorScheme.onSurface),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            _buildStars(review.rate),
          ],
        ),
      ),
    );

    Widget myComment = Dismissible(
        key: ValueKey(review.id), 
        onDismissed: (direction) => onDismiss(ref),       
        child: GestureDetector(
          onTap: () => showEditReviewDialog(context),
          child: otherComments,
        ));

    bool isMine = review.id == firebaseInstance.currentUser!.uid;

    return isMine ? myComment : otherComments;
  }
}
