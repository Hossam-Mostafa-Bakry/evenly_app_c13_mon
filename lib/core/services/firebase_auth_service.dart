import 'dart:developer';

import 'package:evently_app_c13_mon_7pm/core/services/snack_bar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

abstract class FirebaseAuthService {
  static Future<bool> signUp(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      SnackBarService.showSuccessMessage("Account successfully Created");
      return Future.value(true);
    } on FirebaseAuthException catch (firebaseAuthException) {
      if (firebaseAuthException.code == 'weak-password') {
        SnackBarService.showErrorMessage(firebaseAuthException.message ??
            'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (firebaseAuthException.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(firebaseAuthException.message ??
            'The account already exists for that email.');
        print('The account already exists for that email.');
      }
      return Future.value(false);
    } catch (error) {
      print(error.toString());
      return Future.value(false);
    }
  }

  static Future<bool> signIn(String emailAddress, String password) async {
    EasyLoading.show();
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      log(userCredential.user!.uid);

      SnackBarService.showSuccessMessage("Logged in successfully.");
      return Future.value(true);
    } on FirebaseAuthException catch (firebaseAuthException) {
      print(firebaseAuthException.code);

      if (firebaseAuthException.code == 'invalid-credential') {
        SnackBarService.showErrorMessage(
            firebaseAuthException.message ?? 'No user found for that email.');
      } else if (firebaseAuthException.code == 'invalid-credential') {
        SnackBarService.showErrorMessage(
            firebaseAuthException.message ?? 'No user found for that email.');
      }
      return Future.value(false);
    } catch (error) {
      print(error.toString());
      return Future.value(false);
    }
  }
}
