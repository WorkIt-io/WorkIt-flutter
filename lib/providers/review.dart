import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/review.dart';
import 'business.dart';

class ReviewsNotifier extends StateNotifier<List<Review>> {
  ReviewsNotifier(): super([]);
  
  Future getAllReviews() async {
    final List<Review> reviews = [];

    final CollectionReference<Map<String, dynamic>> businessCol =
        FirebaseFirestore.instance
            .collection('business')
            .doc(selectedBusiness!.id)
            .collection("reviews");

    final QuerySnapshot<Map<String, dynamic>> reviewsRef =
        await businessCol.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> item in reviewsRef.docs) {
      final Map<String, dynamic> map = item.data();
      final review = Review.fromMap(map);
      reviews.add(review);
    }

    state = reviews;
  }

  Future postReview(Review review) async {
    final ref = FirebaseFirestore.instance
        .collection('business')
        .doc(selectedBusiness!.id)
        .collection("reviews")
        .doc(review.id);

    final doc = await ref.get();

    if (!doc.exists) // every user can upload 1 review.
    {
      await ref.set(review.toMap());
      _addReview(review);
    } else {
      throw Exception("Already Upload Review");
    }

  }

  Future updateReview(Review review) async {
    final ref = FirebaseFirestore.instance
        .collection('business')
        .doc(selectedBusiness!.id)
        .collection("reviews")
        .doc(review.id);

    final doc = await ref.get();

    if (doc.exists) {
      ref.update(review.toMap());
      List<Review> temp = List.from(state);
      temp = temp.where((element) => element.id != review.id).toList();
      temp.add(review);
      state = temp;
    } else {
      throw Exception("review not found");
    }
  }

  Future deleteReview(Review review) async {
    final ref = FirebaseFirestore.instance
        .collection('business')
        .doc(selectedBusiness!.id)
        .collection("reviews")
        .doc(review.id);

    final doc = await ref.get();

    if (doc.exists) {
      ref.delete();
      _removeReview(review);
    } else {
      throw Exception("no such review");
    }
  }

  void _addReview(Review review)
  {
    state = [...state, review];
  }

  void _removeReview(Review review, {int? index})
  {
    List<Review> temp = List.from(state);
    index == null ? temp.remove(review) : temp.removeAt(index);
    state = temp;
  }
}



final reviewProvider = StateNotifierProvider<ReviewsNotifier, List<Review>>((ref) {
  return ReviewsNotifier();
});
