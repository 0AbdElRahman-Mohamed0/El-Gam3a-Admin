import 'dart:math';

import 'package:elgam3a_admin/models/user_model.dart';
import 'package:elgam3a_admin/services/vars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class UsersProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiProvider _api = ApiProvider.instance;
  UserModel userModel;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*()_+-=';
  Random _rnd = Random();

  String getRandomPassword() => String.fromCharCodes(Iterable.generate(
      15, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  // Future<void> updateUserData(UserModel userUpdates) async {
  //   await firestore
  //       .collection(UserData.USER_DATA_TABLE)
  //       .doc(uid)
  //       .update(userUpdates.toMap());
  //   userModel = userUpdates;
  //   await user.updateEmail(userUpdates.email);
  //   notifyListeners();
  // }

  Future<void> addNewStudent(UserModel user, String pass) async {
    await _api.addNewStudent(user, pass);
  }
}
