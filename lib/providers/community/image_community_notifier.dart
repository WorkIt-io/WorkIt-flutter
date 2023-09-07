import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/community/community_image_repository.dart';
import 'package:workit/api/repository/community/community_repository.dart';
import 'package:workit/common/date_format.dart';
import 'package:workit/providers/community/communities_notifier.dart';



final imageCommunityNotifierProvider = StateNotifierProvider<ImageCommunityNotifier, List<String>>((ref) {
  final imageRepository = ref.watch(communityImageRepositoryProvider);
  return ImageCommunityNotifier(imageRepository, ref);
});

class ImageCommunityNotifier extends StateNotifier<List<String>> {
  ImageCommunityNotifier(this._imageRepository, this._ref): super([]);

  final CommunityImageRepository _imageRepository;
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

  Future<void> uploadCommunityImage(File image) async {
    final imageId = generateTimestamp();
    final String downloadUrl = await _imageRepository.uploadCommunityImage(image, imageId);
    
    _updateCommunityImages({'images': downloadUrl});    
    _addImage(downloadUrl);    
  }

  Future removeLastImage() async {    
    final currentCommunity = await _ref.read(communityRepositoryProvider).getSelectedCommunity();    

    await _imageRepository.removeImage();

    String removeImageUrl = currentCommunity.images.removeLast();

    currentCommunity.images.isEmpty
        ? _updateCommunityImages({'images': null})
        : _updateCommunityImages({'images': currentCommunity.images});

    _removeImage(removeImageUrl);
  }

  Future<void> _updateCommunityImages(Map<String, dynamic> map) async {
    await _ref
        .read(communitiesStateNotifierProvider.notifier)
        .updateCommunity(map);
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

  
}

