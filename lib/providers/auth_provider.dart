import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiProvider _api = ApiProvider.instance;

  bool get isAuth => uid != null;

  String get uid => auth.currentUser?.uid;

  User get user => auth.currentUser;

  isSignedIn() {
    return auth.currentUser != null;
  }

  Future<void> logIn(String email, String password) async {
    await _api.signInUsingEmailAndPassword(email, password);
    notifyListeners();
  }

  bool tryAutoLogin() => isAuth;

  Future<void> logOut() async {
    await auth.signOut();
//    userModel = UserModel();

    notifyListeners();
  }

  // Future<void> forgetPassword(String email) async {
  //   await _api.forgetPassword(email);
  //   notifyListeners();
  // }

  /////// Delete fireStore image ////////
  // Future<void> deleteImage(String imagePath) async {
  //   await _api.deleteFireBaseStorageImage(imagePath);
  // }

}
