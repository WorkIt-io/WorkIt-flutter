import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/business.dart';

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepository(FirebaseStorage.instance, FirebaseAuth.instance);
});

class ImageRepository {
  ImageRepository(this._firebaseStorage, this._firebase);

  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebase;

  Future<String> uploadBussinesImage(File image) async {
    final businessId = selectedBusiness!.id;
    var ref =
        _firebaseStorage.ref('businesses').child(businessId).child('images');
    await ref.putFile(image);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<List<String>> retriveAllImages() async {
    List<String> downloadUrl = [];
    final businessId = selectedBusiness!.id;
    ListResult listResult = await _firebaseStorage
        .ref('businesses')
        .child(businessId)
        // .child('images')
        .list();

    for (Reference item in listResult.items) {
      String url = await item.getDownloadURL();
      downloadUrl.add(url);
    }

    return downloadUrl;
  }

  Future removeLastImage() async {
    final businessId = selectedBusiness!.id;
    ListResult listResult = await _firebaseStorage
        .ref('businesses')
        .child(businessId)
        // .child('images')
        .list();

    final imageRef = listResult.items.last;
    await imageRef.delete();
  }

  Future<String> uploadProfileUserImage(File image) async {
    final userId = _firebase.currentUser!.uid;
    final doc = _firebaseStorage.ref('users').child(userId);
    await doc.putFile(image);
    String downloadUrl = await doc.getDownloadURL();
    return downloadUrl;
  }
}
