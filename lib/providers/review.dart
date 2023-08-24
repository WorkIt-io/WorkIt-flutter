import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/review_repository.dart';
import '../models/review.dart';
import 'business.dart';

class ReviewsNotifier extends StateNotifier<List<Review>> {
  final ReviewRepository _reviewRepository;

  ReviewsNotifier(this._reviewRepository) : super([]);

  Future getAllReviews() async {
    state = await _reviewRepository.getAllReviews();
  }

  Future postReview(String title, String text, int rate) async {
    final review = await _reviewRepository.postReview(title, text, rate);
    _addReview(review);
  }

  Future updateReview(String title, String text, int rate) async {
    final review = await _reviewRepository.updateReview(title, text, rate);
    _updateReview(review);
  }

  Future deleteReview() async {
      final review = await _reviewRepository.deleteReview();
      _removeReview(review);
  }

  void _addReview(Review review) {
    state = [...state, review];
  }

  void _removeReview(Review review, {int? index}) {
    List<Review> temp = List.from(state);
    index == null ? temp.remove(review) : temp.removeAt(index);
    state = temp;
  }

  void _updateReview(Review review) {
    List<Review> temp = List.from(state);
    temp = temp.where((element) => element.id != review.id).toList();
    temp.add(review);
    state = temp;
  }
}

final reviewProvider =
    StateNotifierProvider<ReviewsNotifier, List<Review>>((ref) {
  final reviewRepository = ref.watch(reviewRepositoryProvider);
  return ReviewsNotifier(reviewRepository);
});
