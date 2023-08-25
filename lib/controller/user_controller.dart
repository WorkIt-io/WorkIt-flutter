

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/user_repository.dart';

import '../models/user_model.dart';

final userControllerProvider = Provider<UserController>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserController(userRepository);
});

class UserController
{
  final UserRepository _userRepository;  

  UserController(this._userRepository);

  Future setIntialData(String email, String fullName)
  async {
    await _userRepository.setInitialData(email, fullName);
  }

  Future updateProfilePicture(String downloadUrl) async {      
      await _userRepository.updateProfilePicture(downloadUrl);    
  }

  Future getUser()
  async {
    final Map<String, dynamic> map = await _userRepository.getUser();
    return UserModel.fromMap(map);
  }  
}

