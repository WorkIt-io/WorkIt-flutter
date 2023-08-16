import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:workit/providers/business.dart';

class ImageBusinessApi {
  static String get _path => "${selectedBusiness!.id}/business_image";

  static Future<String> uploadToFireBase({required String fileName, required File image}) async {
    try {
      var ref = FirebaseStorage.instance.ref('$_path/$fileName');
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

  static Future removeImage({required int fileIdToRemove}) async
  {
    final String pathToRemove = "$_path/$fileIdToRemove.jpg";
    await FirebaseStorage.instance.ref(pathToRemove).delete();
  }
}
