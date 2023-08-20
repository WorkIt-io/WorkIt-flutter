import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:workit/common/snack_bar_custom.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});


class AuthRepository {
  const AuthRepository(this.firebaseAuth, this.firestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      SnakcBarCustom.showSnackBar(context, e.message!);
    }
  }

  Future<void> signup(BuildContext context, String email, String password) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firebaseAuth.currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      SnakcBarCustom.showSnackBar(context, e.message!);
    }
  }

  Stream<User?> getCurrentUser() {
    return firebaseAuth.authStateChanges();
  }
}
