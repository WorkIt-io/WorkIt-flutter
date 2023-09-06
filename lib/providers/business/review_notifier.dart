import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/business/review_repository.dart';
import 'package:workit/models/review.dart';
import 'package:workit/providers/business/businesses_notifier.dart';

import 'package:workit/utils/review_widget_helper.dart';



class ReviewsNotifier extends StateNotifier<List<Review>> {
  final ReviewRepository _reviewRepository;
  final FirebaseAuth firebase;
  final StateNotifierProviderRef _ref;

  ReviewsNotifier(this._reviewRepository, this.firebase, this._ref) : super([]);

  Future getAllReviews() async {
    List<Review> reviews = await _reviewRepository.getAllReviews();
    Review? myReview;
    for (var review in reviews) {
      if (review.id == firebase.currentUser!.uid) {
        myReview = review;
        break;
      }
    }

    if (myReview != null) {
      reviews.remove(myReview);
      reviews.insert(0, myReview);
    }

    state = reviews;
  }

  Future postReview(String title, String text, int rate) async {
    final review = await _reviewRepository.postReview(title, text, rate);
    _addReview(review);
    await _updateBusinessRate();
  }

  Future updateReview(String title, String text, int rate) async {
    final review = await _reviewRepository.updateReview(title, text, rate);
    _updateReview(review);
    await _updateBusinessRate();
  }

  Future deleteReview() async {
    await _reviewRepository.deleteReview();
    _removeReview();
    await _updateBusinessRate();
  }

  void _addReview(Review review) {
    state = [review, ...state];
  }

  void _removeReview() {
    List<Review> temp = List.from(state);
    Review myReview = temp.firstWhere((element) => element.id == firebase.currentUser!.uid);
    temp.remove(myReview);
    state = temp;
  }

  void _updateReview(Review review) {
    List<Review> temp = List.from(state);
    temp = temp.where((element) => element.id != review.id).toList();
    temp.add(review);
    state = temp;
  }

  // to keep the local + firestore rate update
  Future<void> _updateBusinessRate() async {
    final newRate = ReviewWidgetHelper.calcAvgRate(state);
    _ref
        .read(businessesStateNotifierProvider.notifier)
        .updateBusiness({'rate': newRate});
  }
}

final reviewStateNotifierProvider =
    StateNotifierProvider<ReviewsNotifier, List<Review>>((ref) {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  return ReviewsNotifier(reviewRepository, FirebaseAuth.instance, ref);
});
