import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constant/firebase_instance.dart';

class FirestoreApi {
  static Future setEmailRole(UserCredential user) async {
    final ref =
        FirebaseFirestore.instance.collection('users').doc(user.user!.uid);

    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set({'email': user.user?.email, 'role': 'User'});
    }
  }
}
