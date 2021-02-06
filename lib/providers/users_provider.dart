import 'dart:math';

import 'package:elgam3a_admin/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class UsersProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ApiProvider _api = ApiProvider.instance;
  UserModel user;

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#%^&*()_+-=';
  Random _rnd = Random();

  String getRandomPassword() => String.fromCharCodes(Iterable.generate(
      6, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> addNewUser(UserModel user, String pass) async {
    await _api.addNewUser(user, pass);
  }

  Future<UserModel> getDataOfStudentByUnivID(String univID) async {
    user = await _api.getDataOfStudentByUnivID(univID);
    notifyListeners();
    return user;
  }

  Future<void> deleteUser(String univID) async {
    await _api.deleteUser(univID);
  }

  /////// Delete fireStore image ////////
  Future<void> deleteImage(String imagePath) async {
    await _api.deleteFireBaseStorageImage(imagePath);
  }

  /////////////UPDATE/////////////////////////////////////////////
  Future<void> updateUser(UserModel user) async {
    await _api.updateUser(user);
  }
}
