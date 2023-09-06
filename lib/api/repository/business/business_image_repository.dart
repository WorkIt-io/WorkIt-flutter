import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/storage_api.dart';
import 'package:workit/providers/business/business_id.dart';


final businessImageRepositoryProvider =
    Provider<BusinessImageRepository>((ref) {
  final storageApi = ref.watch(storageApiProvider);
  return BusinessImageRepository(storageApi, ref);
});

class BusinessImageRepository {
  BusinessImageRepository(this._storageApi, this._ref);

  final StorageApi _storageApi;
  final ProviderRef _ref;

  String get path => 'businesses/$getBusinessId/images';

  String get getBusinessId => _ref.read(businessIdProvider);

  Future<List<String>> retriveAllImages() async {
    List<String> downloadsUrl = [];
    ListResult listResult = await _storageApi.retriveAll(path);

    for (var element in listResult.items) {
      final url = await element.getDownloadURL();
      downloadsUrl.add(url);
    }

    return downloadsUrl;
  }

  Future<String> getPreviewImage() async {
    ListResult listResult = await _storageApi.retriveAll(path);

    final previewImageRef = listResult.items.first;

    return await previewImageRef.getDownloadURL();
  }

  Future<String> uploadBussinesImage(File image, String imageId) async {
    final String endPoint = '$path/$imageId';

    await _storageApi.uploadFile(endPoint, image);

    return await _storageApi.getRefrence(endPoint).getDownloadURL();
  }

  Future<void> removeImage() async {
    ListResult listResult = await _storageApi.retriveAll(path);

    final Reference imageToRemove = listResult.items.last;

    await _storageApi.deleteFile(imageToRemove.fullPath);
  }
}
