// ignore_for_file: use_build_context_synchronously, unused_catch_clause, avoid_print, non_constant_identifier_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasky_app/models/user_model.dart';
import 'package:tasky_app/utils/dialogs.dart';

class Authentication {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  static get user => auth.currentUser;

  static Future<bool> userExists() async {
    return (await firestore
            .collection('users')
            .doc(auth.currentUser!.uid)
            .get())
        .exists;
  }

  static Stream<DocumentSnapshot<Map<String, dynamic>>> getuserInfo(
      String userid) {
    return Authentication.firestore.collection('users').doc(userid).snapshots();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getuserbyEmail(
      String userid) {
    return Authentication.firestore
        .collection('users')
        .where('email', isEqualTo: userid)
        .snapshots();
  }

  // for inserting user into database

  static Future<void> createUser() async {
    final time = DateTime.timestamp();
    final UserModel userdata = UserModel(
      id: user.uid,
      name: user.displayName.toString(),
      about: "Hey I'm using Osm Chat",
      image: user.photoURL.toString(),
      lastActive: time.millisecondsSinceEpoch.toString(),
      email: user.email.toString(),
      pushToken: '',
      createdAt: time.millisecondsSinceEpoch.toString(),
    );
    await firestore.collection('users').doc(user.uid).set(userdata.toJson());
  }

  static Future<void> updateInfo(String value, String valueKey) async {
    await firestore.collection('users').doc(user.uid).update({valueKey: value});
  }

  static Future<UserCredential?> createUserWithEmailAndPass(
      String email, String password, String name, BuildContext context) async {
    try {
      if (!kIsWeb) {
        await InternetAddress.lookup('google.com');
      }
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // await updateInfo(name, 'displayName');
      await auth.currentUser!.updateDisplayName(name);
      await createUser();
      return credential;
    } on SocketException catch (e) {
      Dialogs.showSnackBar(context, 'Please Connect to internet', true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Dialogs.showSnackBar(
            context, 'The password provided is too weak.', true);
      } else if (e.code == 'email-already-in-use') {
        Dialogs.showSnackBar(
            context, 'The account already exists for that email.', true);
      }
    } catch (e) {
      print(e);
      Dialogs.showSnackBar(context, 'Ohho Error occured. ', true);
    }
    return null;
  }

  static loginWithEmailAndPass(
      String email, String password, BuildContext context) async {
    try {
      if (!kIsWeb) {
        await InternetAddress.lookup('google.com');
      }
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on SocketException catch (e) {
      Dialogs.showSnackBar(context, 'Please Connect to internet', true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print(e);
        return Dialogs.showSnackBar(context, 'No user found ', true);
      } else if (e.code == 'wrong-password') {
        return Dialogs.showSnackBar(
            context, 'Wrong password provided for that user. ', true);
      }
    } catch (e) {
      print(e);
      Dialogs.showSnackBar(context, 'Ohho Error occured. ', true);
    }
  }

  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      if (!kIsWeb) {
        await InternetAddress.lookup('google.com');
      }
      if (kIsWeb) {
        GoogleAuthProvider authProvider = GoogleAuthProvider();
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);
        // print(userCredential);
        if (await userExists() == false) {
          createUser();
        }
        return userCredential;
      } else {
        // Trigger the authentication flow
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        final UserCred = await auth.signInWithCredential(credential);
        if (await userExists() == false) {
          createUser();
        }

        // Once signed in, return the UserCredential
        return UserCred;
      }
    } on SocketException catch (e) {
      print("SocketException: $e");
      Dialogs.showSnackBar(context, 'Please Connect to internet', true);
    } catch (e) {
      print(e);
      Dialogs.showSnackBar(
          context, 'Something is wrong Please try again', true);
    }
    return null;
  }

  static forgotPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return Dialogs.showSnackBar(context, 'Reset Email Sent!', false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Dialogs.showSnackBar(
            context, 'Entered Email is not valid No User Found', true);
      } else {
        Dialogs.showSnackBar(context, ' Authentication Error', true);
      }
    } catch (e) {
      print(e);
      Dialogs.showSnackBar(context, ' Authentication Error', true);
    }
    return null;
  }

  static Future<void> signout(BuildContext context) async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      Dialogs.showSnackBar(context, 'Logged out Successfully', false);
    } catch (e) {
      print(e);
    }
  }
}
