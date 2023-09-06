import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/user_repository.dart';

import '../models/user_model.dart';

final userControllerProvider = Provider<UserController>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository);
});

final userDataFutureProvider = FutureProvider.autoDispose((ref) {
  final userController = ref.watch(userControllerProvider);
  return userController.getUser();
});

class UserController {
  final UserRepository _userRepository;

  UserController(this._userRepository);

  Future setIntialData(String email, String fullName) async {
    await _userRepository.setInitialData(email, fullName);
  }

  Future _updateProfilePicture(String downloadUrl) async {
    await _userRepository.updateProfilePicture(downloadUrl);
  }

  Future uploadProfilePicture(File image) async
  {
    String downloadUrl = await _userRepository.uploadProfilePicture(image);
    _updateProfilePicture(downloadUrl);
  }

  Future deleteUser() async {
    await _userRepository.deleteUser();
  }

  Future updateUser(Map<String, dynamic> map) async {
    await _userRepository.updateUser(map);
  }

  Future<UserModel> getUser() async {
    final Map<String, dynamic> map = await _userRepository.getUser();
    return UserModel.fromMap(map);
  }
}
