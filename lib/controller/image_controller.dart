import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:workit/api/repository/business_repository.dart';
import 'package:workit/controller/business_controller.dart';
import 'package:workit/controller/user_controller.dart';

import '../api/repository/image_repository.dart';
import '../models/user_model.dart';

final imageControllerProvider = Provider<ImageController>((ref) {
  final imageRepository = ref.watch(imageRepositoryProvider);
  return ImageController(imageRepository, ref);
});

class ImageController {
  final ImageRepository _imageRepository;
  final ProviderRef _ref;
  final Uuid uuid = const Uuid();

  ImageController(this._imageRepository, this._ref);

  Future<String> uploadBussinesImage(File image) async {
    final imageId = uuid.v1();    
    final String downloadUrl = await _imageRepository.uploadBussinesImage(image, imageId);
    await _ref.read(businessRepositoryProvider).updateBusinessImageId(imageId);
    return downloadUrl;
  }

  Future<void> uploadProfileUserImage(File image) async {
    UserModel user = await _ref.read(userControllerProvider).getUser();
    if (user.imageUrl == null) {
      final String imageUrl =
          await _imageRepository.uploadProfileUserImage(image);
      _ref.read(userControllerProvider).updateProfilePicture(imageUrl);
    } // can throw exception but for know user just return void.
  }

  Future<List<String>> retriveAllImages() async {
    return await _imageRepository.retriveAllImages();
  }

  Future removeLastImage(int imageIndex) async {
    final selectedBusinessModel = await _ref.read(businessRepositoryProvider).getSelectedBusiness();
    final imageId = selectedBusinessModel.imagesId![imageIndex];
    await _imageRepository.removeImage(imageId);
  }
}
