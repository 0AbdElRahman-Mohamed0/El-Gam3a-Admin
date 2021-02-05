import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:elgam3a_admin/services/vars.dart';
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

  UserModel userModel;

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
}
