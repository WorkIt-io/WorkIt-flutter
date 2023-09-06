import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/providers/business/review_notifier.dart';


import '../../../models/review.dart';
import 'comment.dart';

class CommentsList extends ConsumerWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Review> reviews = ref.watch(reviewStateNotifierProvider);
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) => Comment(reviews[index]),
      shrinkWrap: true,
    );
  }
}
