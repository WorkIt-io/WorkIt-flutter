import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/user_repository.dart';
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

  ImageController(this._imageRepository, this._ref);

  Future<String> uploadBussinesImage(File image) async {
    return await _imageRepository.uploadBussinesImage(image);
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

  Future removeLastImage() async {
    await _imageRepository.removeLastImage();
  }
}
