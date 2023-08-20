import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/api/repository/auth_repository.dart';

final authControllerProvider = Provider<AuthController>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(authRepository);
});


final userStreamAuthProvider = StreamProvider<User?>((ref) {
  final userStreamAuth = ref.watch(authControllerProvider);
  return userStreamAuth.getCurrentUser();
});

class AuthController {

  AuthController(this.authRepository);

  final AuthRepository authRepository;

  Stream<User?> getCurrentUser()
  {
    return authRepository.getCurrentUser();
  }
    
  void login(BuildContext context, String email, String password)
  {
    authRepository.login(context, email, password);
  }

  void signup(BuildContext context, String email, String password)
  {
    authRepository.signup(context, email, password);
  }
}