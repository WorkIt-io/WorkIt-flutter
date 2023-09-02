import 'package:firebase_auth/firebase_auth.dart';
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
    
  Future<void> login(String email, String password) async
  {
    await authRepository.login(email, password);
  }

  Future<void> signup(String email, String password, String fullName)
  async {
    await authRepository.signup(email, password, fullName);
  }

  Future<void> googleSignIn() async
  {
    await authRepository.googleSignIn();
  }

  Future<void> signOut()
  async {
    authRepository.signOut();
  }
}