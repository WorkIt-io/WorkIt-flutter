import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/models/review.dart';
import 'package:workit/providers/business.dart';

final reviewRepositoryProvider = Provider<ReviewRepository>((ref) {
  return ReviewRepository(FirebaseFirestore.instance, FirebaseAuth.instance);
});

class ReviewRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebase;

  ReviewRepository(this._firestore, this._firebase);

  Future<List<Review>> getAllReviews() async {
    final List<Review> reviews = [];
    final businessId = selectedBusiness!.id;

    final CollectionReference<Map<String, dynamic>> businessCol =
        FirebaseFirestore.instance
            .collection('businesses')
            .doc(businessId)
            .collection("reviews");

    final QuerySnapshot<Map<String, dynamic>> reviewsRef =
        await businessCol.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> item in reviewsRef.docs) {
      final Map<String, dynamic> map = item.data();
      final review = Review.fromMap(map);
      reviews.add(review);
    }

    return reviews;
  }

  Future<Review> postReview(String title, String text, int rate) async {
    final review = Review(
        id: _firebase.currentUser!.uid, title: title, text: text, rate: rate);
    final businessId = selectedBusiness!.id;

    final ref = _firestore
        .collection('businesses')
        .doc(businessId)
        .collection("reviews")
        .doc(review.id);

    final doc = await ref.get();

    if (!doc.exists) // every user can upload 1 review.
    {
      await ref.set(review.toMap());
      return review;
    } else {
      throw Exception("Already Upload Review");
    }
  }

  Future<Review> updateReview(String title, String text, int rate) async {
    final review = Review(
        id: _firebase.currentUser!.uid, title: title, text: text, rate: rate);
    final businessId = selectedBusiness!.id;

    final ref = _firestore
        .collection('businesses')
        .doc(businessId)
        .collection("reviews")
        .doc(review.id);

    final doc = await ref.get();

    if (doc.exists) {
      await ref.update(review.toMap());
      return review;
    } else {
      throw Exception("review not found");
    }
  }

  Future<void> deleteReview() async {
    final reviewId = _firebase.currentUser!.uid;
    final businessId = selectedBusiness!.id;

    final ref = _firestore
        .collection('businesses')
        .doc(businessId)
        .collection("reviews")
        .doc(reviewId);

    final doc = await ref.get();

    if (doc.exists) {      
      await ref.delete();      
    } else {
      throw Exception("no such review");
    }
  }
}
