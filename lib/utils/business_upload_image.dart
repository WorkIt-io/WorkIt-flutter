import 'dart:io';

import 'package:workit/constant/firebase_instance.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BusinessUploadImage {
  static String get _path => "user_images/${firebaseInstance.currentUser!.uid}";

  static Future<String> uploadToFireBase({required String fileName, required File image}) async {
    final String pathToUpload = "$_path/$fileName";
    try {
      var ref = FirebaseStorage.instance.ref(pathToUpload);
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String>> retriveAllImages ()
  async {
    List<String> downloadUrl = [];
    ListResult listResult = await FirebaseStorage.instance.ref(_path).list();

    for (Reference item in listResult.items) {
      String url = await item.getDownloadURL();      
      downloadUrl.add(url);
    }

    return downloadUrl;    
  }

  static Future removeImage(int length) async
  {
    final String pathToRemove = "$_path/$length.jpg";
    await FirebaseStorage.instance.ref(pathToRemove).delete();
  }
}
