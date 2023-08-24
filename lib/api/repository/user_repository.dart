import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});

class UserRepository {
  final FirebaseAuth _firebase;
  final FirebaseFirestore _firestore;

  UserRepository(this._firebase, this._firestore);

  Future setInitialData(String email, String fullName) async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);
    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set({'email': email, 'name': fullName, 'role': 'User'});
    }
  }

  Future updateProfilePicture(String downloadUrl) async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);

    await ref.update({
      'image': downloadUrl,
    });
  }

  Future<Map<String, dynamic>> getUser() async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);
    final doc = await ref.get();
    return doc.data()!;
  }
}
