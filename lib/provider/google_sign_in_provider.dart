// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  // final googleSignIn = GoogleSignIn();

  // GoogleSignInAccount? _user;

  // GoogleSignInAccount get user => _user!;

  // Future googleLogin() async {
  //   try {
  //     final googleUser = await googleSignIn.signIn();
  //     if (googleUser == null) return;
  //     _user = googleUser;

  //     final googleAuth = await googleUser.authentication;

  //     final credential = GoogleAuthProvider.credential(
  //         accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  Future<UserCredential> googleLogin() async {
    //create an instance of the firebase auth and google sign in
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    //triger the authenticaiton flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    //Obtain the auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    //create new credentials
    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    //sign in the user with the credentials
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);
    return userCredential;
  }

  Future logOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }
  // notifyListeners();
}
