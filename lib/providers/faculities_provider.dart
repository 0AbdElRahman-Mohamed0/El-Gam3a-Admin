import 'package:elgam3a_admin/models/faculty_model.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';

class FacultiesProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<FacultyModel> faculties = [];

  Future<void> getFaculties() async {
    faculties = await _api.getFaculties();
    notifyListeners();
  }

  updateHalls(HallModel hall, String facultyID) async {
    final halls =
        faculties.firstWhere((element) => element.id == facultyID).halls;
    halls.add(hall);
    await _api.addHall(halls, facultyID);
  }
}
