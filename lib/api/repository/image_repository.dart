import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../common/pair.dart';
import '../../providers/business.dart';

final imageRepositoryProvider = Provider<ImageRepository>((ref) {  
  return ImageRepository(FirebaseStorage.instance, FirebaseAuth.instance);
});

class ImageRepository {
  ImageRepository(this._firebaseStorage, this._firebase);

  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebase;   

    Future<List<String>> retriveAllImages() async {    
    List<Pair<FullMetadata, String>> metaDataUrlList = [];

    final businessId = selectedBusiness!.id;

    ListResult listResult = await _firebaseStorage
        .ref('businesses')
        .child(businessId)
        .child('images')        
        .list();

    for (Reference item in listResult.items) {      
      final itemMetaData = await item.getMetadata();      
      String url = await item.getDownloadURL();
      metaDataUrlList.add(Pair(itemMetaData, url));
    }
    
    metaDataUrlList.sort((a, b) => a.first.timeCreated!.compareTo(b.first.timeCreated!));
    List<String> downloadUrl = metaDataUrlList.map((e) => e.second).toList();
    return downloadUrl;
  }

  Future<String> getPreviewImage() async {
    final businessId = selectedBusiness!.id;

    ListResult listResult = await _firebaseStorage
        .ref('businesses')
        .child(businessId)
        .child('images')        
        .list();
    
    final previewImageRef =  listResult.items.first;

    return await previewImageRef.getDownloadURL();
  }

  Future<String> uploadBussinesImage(File image, String imageId) async {
    final String businessId = selectedBusiness!.id;    

    var ref =
        _firebaseStorage.ref('businesses').child(businessId).child('images').child(imageId);

            

    await ref.putFile(image);
    String downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }

  Future<void> removeImage() async {
    final businessId = selectedBusiness!.id;

    final ref = _firebaseStorage
        .ref('businesses')
        .child(businessId)
        .child('images');

    final ListResult images = await ref.list();
    final Reference imageToRemove = images.items.last;
    await imageToRemove.delete();        
  }


  // ========================= profile images ================================

  Future<String> uploadProfileUserImage(File image) async {
    final userId = _firebase.currentUser!.uid;
    final doc = _firebaseStorage.ref('users').child(userId);
    await doc.putFile(image);
    String downloadUrl = await doc.getDownloadURL();
    return downloadUrl;
  }
}
