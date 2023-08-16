import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/constant/firebase_instance.dart';
import 'package:workit/providers/review.dart';

import '../../../models/review.dart';
import 'comment.dart';

class CommentsList extends ConsumerWidget {
  const CommentsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Review> reviews = ref.watch(reviewProvider);
    List<Review> reviewsMyCommentFirst = List.from(reviews);
    int myReviewindex = reviewsMyCommentFirst.indexWhere((review) => review.id == firebaseInstance.currentUser!.uid);

    if (myReviewindex != -1 && myReviewindex != 0)
    {      
      Review myReview = reviewsMyCommentFirst.removeAt(myReviewindex);
      reviewsMyCommentFirst.insert(0, myReview);
    }
    
    return ListView.builder(itemCount: reviewsMyCommentFirst.length ,itemBuilder: (context, index) => Comment(reviewsMyCommentFirst[index]),shrinkWrap: true,);
  }
}