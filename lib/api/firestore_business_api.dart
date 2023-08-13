import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/review.dart';
import '../providers/business.dart';


class FirestoreBusinessApi {
  static Future postReview(Review review)
  async {
    final ref = FirebaseFirestore.instance.collection('business').doc(selectedBusiness!.id).collection("reviews").doc(review.id);

    final doc = await ref.get();

    if (!doc.exists) // every user can upload 1 review.
    {
      await ref.set(review.toMap());
    }
    else
    {
      throw Exception("Already Upload Review");
    }
  }

  static Future deleteReview(Review review)
  async {    
    final ref = FirebaseFirestore.instance.collection('business').doc(selectedBusiness!.id).collection("reviews").doc(review.id);

    final doc = await ref.get();

    if(doc.exists)
    {
      ref.delete();      
    }
    else
    {
      throw Exception("no such review");
    }
    
  }
}
