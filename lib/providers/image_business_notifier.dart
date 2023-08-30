import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/business_repository.dart';
import 'package:workit/common/date_format.dart';
import 'package:workit/controller/user_controller.dart';

import '../api/repository/image_repository.dart';
import '../models/user_model.dart';
import 'businesses_notifier.dart';


final imageBusinessNotifierProvider = StateNotifierProvider<ImageBusinessNotifier, List<String>>((ref) {
  final imageRepository = ref.watch(imageRepositoryProvider);
  return ImageBusinessNotifier(imageRepository, ref);
});

class ImageBusinessNotifier extends StateNotifier<List<String>> {
  ImageBusinessNotifier(this._imageRepository, this._ref): super([]);

  final ImageRepository _imageRepository;
  final StateNotifierProviderRef _ref;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> retriveAllImages() async {
    _isLoading = true;
    List<String> temp = await _imageRepository.retriveAllImages();    
    _isLoading = false;
    state = temp;
  }

  Future<String> getPreviewImage() async {
    // first image is the preview
    return state[0];
  }

  Future<void> uploadBussinesImage(File image) async {
    final imageId = generateTimestamp();
    final String downloadUrl = await _imageRepository.uploadBussinesImage(image, imageId);
    
    _updateBusinessImages({'images': downloadUrl});    
    _addImage(downloadUrl);    
  }

  Future removeLastImage() async {    
    final currentBusiness = await _ref.read(businessRepositoryProvider).getSelectedBusiness();    

    await _imageRepository.removeImage();

    String removeImageUrl = currentBusiness.images.removeLast();

    currentBusiness.images.isEmpty
        ? _updateBusinessImages({'images': []})
        : _updateBusinessImages({'images': currentBusiness.images});

    _removeImage(removeImageUrl);
  }

  Future<void> _updateBusinessImages(Map<String, dynamic> map) async {
    await _ref
        .read(businessesStateNotifierProvider.notifier)
        .updateBusiness(map);
  }

  void _addImage(String imageUrl)
  {
    state = [...state, imageUrl];
  }

  void _removeImage(String imageUrl)
  {               
    List<String> temp = List.from(state);
    temp.remove(imageUrl);
    state = temp;
  }


  // move this function from the state notifier later
  Future<void> uploadProfileUserImage(File image) async {
    UserModel user = await _ref.read(userControllerProvider).getUser();
    if (user.imageUrl == null) {
      final String imageUrl =
          await _imageRepository.uploadProfileUserImage(image);
      _ref.read(userControllerProvider).updateProfilePicture(imageUrl);
    } // can throw exception but for know user just return void.
  }

  
}

