import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:workit/api/repository/user_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AuthRepository(
      FirebaseAuth.instance, FirebaseFirestore.instance, userRepository);
});

class AuthRepository {
  const AuthRepository(this.firebaseAuth, this.firestore, this._userRepository);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final UserRepository _userRepository;

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signup(String email, String password, String fullName) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    await firebaseAuth.currentUser!.sendEmailVerification();

    _userRepository.setInitialData(email, fullName);
  }

  Future<void> googleSignIn() async {
    try {

      final GoogleSignInAccount? googleUser =
          await GoogleSignIn().signIn();

      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);

      _userRepository.setInitialData(
          userCredential.user!.email!, userCredential.user!.displayName ?? '');
    } catch (error) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    await firebaseAuth.signOut();
  }

  Stream<User?> getCurrentUser() {
    return firebaseAuth.authStateChanges();
  }
}
