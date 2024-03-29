import 'package:elgam3a_admin/models/faculty_model.dart';
import 'package:elgam3a_admin/models/hall_model.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class FacultiesProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<FacultyModel> faculties = [];

  Future<void> getFaculties() async {
    faculties = await _api.getFaculties();
    notifyListeners();
  }

  Future<void> addHall(HallModel hall, String facultyID) async {
    final halls =
        faculties.firstWhere((element) => element.id == facultyID).halls;

    if (halls.where((element) => element.id == hall.id).isEmpty) {
      halls.add(hall);
      await _api.updateHall(halls, facultyID);
    }
  }

  Future<void> deleteHall(HallModel hall, String facultyID) async {
    final halls =
        faculties.firstWhere((element) => element.id == facultyID).halls;
    halls.removeWhere((element) => element.id == hall.id);
    if (halls.where((element) => element.id == hall.id).isEmpty) {
      await _api.updateHall(halls, facultyID);
    }
  }
}
