import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/storage_api.dart';
import 'package:workit/models/user_model.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(FirebaseAuth.instance, FirebaseFirestore.instance, ref);
});

class UserRepository {
  final FirebaseAuth _firebase;
  final FirebaseFirestore _firestore;
  final ProviderRef _ref;

  UserRepository(this._firebase, this._firestore, this._ref);

  String get path => 'users/${_firebase.currentUser!.uid}';

  Future setInitialData(String email, String fullName) async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);
    final doc = await ref.get();

    if (!doc.exists) {
      await ref.set(UserModel(email: email, fullName: fullName, role: 'User', imageUrl: null, businessId: null, communityId: null).toMap());
    }
  }

  Future updateUser(Map<String, dynamic> map)
  async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);

    final userDoc = await ref.get();
    final userMap = userDoc.data();

    if (userMap == null) throw Exception("No such user");

    map.forEach((key, value) {
      if (userMap.containsKey(key))
      {
        ref.update({key: value});
      }
      else
      {
        throw Exception("No such key");
      }  
    });
    

  }

  Future updateProfilePicture(String downloadUrl) async {    
    updateUser({
      'image': downloadUrl,
    });
  }

  Future<String> uploadProfilePicture(File image)
  async {
    await _ref.read(storageApiProvider).uploadFile(path, image);
    return await _ref.read(storageApiProvider).getRefrence(path).getDownloadURL();
  }

  // Future deleteUser() async {
  //   final userId = _firebase.currentUser!.uid;
  //   final ref = _firestore.collection('users').doc(userId);

  //   await ref.delete();
  // }

  Future<Map<String, dynamic>> getUser() async {
    final userId = _firebase.currentUser!.uid;
    final ref = _firestore.collection('users').doc(userId);
    final doc = await ref.get();
    return doc.data()!;
  }
}
