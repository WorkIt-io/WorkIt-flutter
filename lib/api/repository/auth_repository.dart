import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance, FirebaseFirestore.instance);
});


class AuthRepository {
  const AuthRepository(this.firebaseAuth, this.firestore);

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  Future<void> login(
      BuildContext context, String email, String password) async {    
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);      
  }

  Future<void> signup(BuildContext context, String email, String password) async {

      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firebaseAuth.currentUser!.sendEmailVerification();

  }

  Stream<User?> getCurrentUser() {
    return firebaseAuth.authStateChanges();
  }
}
