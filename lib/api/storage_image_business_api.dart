import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:workit/models/business.dart';

class ImageBusinessApi {
  static String get _path => "business_image/";

  static Future<String> uploadToFireBase({required String fileName, required File image, required Business business}) async {
    final String pathToUpload = "${business.id}/$_path/$fileName";
    try {
      var ref = FirebaseStorage.instance.ref(pathToUpload);
      await ref.putFile(image);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<String>> retriveAllImages ({required Business business})
  async {
    List<String> downloadUrl = [];
    ListResult listResult = await FirebaseStorage.instance.ref("${business.id}/$_path").list();

    for (Reference item in listResult.items) {
      String url = await item.getDownloadURL();      
      downloadUrl.add(url);
    }

    return downloadUrl;    
  }

  static Future removeImage({required int fileIdToRemove, required Business business}) async
  {
    final String pathToRemove = "${business.id}/$_path/$fileIdToRemove.jpg";
    await FirebaseStorage.instance.ref(pathToRemove).delete();
  }
}
