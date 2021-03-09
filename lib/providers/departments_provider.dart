import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/services/api.dart';
import 'package:flutter/material.dart';

export 'package:provider/provider.dart';

class DepartmentsProvider extends ChangeNotifier {
  final ApiProvider _api = ApiProvider.instance;
  List<DepartmentModel> departments = [];
  List<String> departmentsStrings = [];
  List<CourseModel> courses = [];
  CourseModel course;

  Future<void> getDepartments() async {
    departments = await _api.getDepartments();
    for (DepartmentModel department in departments) {
      departmentsStrings.add(department.name);
    }
    notifyListeners();
  }

  Future<void> addCourse(CourseModel course, String departmentID) async {
    final courses =
        departments.firstWhere((element) => element.id == departmentID).courses;
    if (courses
        .where((element) => element.courseCode == course.courseCode)
        .isEmpty) {
      courses.add(course);
      await _api.updateCourse(courses, departmentID);
    }
  }

  Future<void> getCourseByCode(String courseCode) async {
    course = await _api.getCourseByCode(courseCode);
    notifyListeners();
  }

  Future<void> updateCourse(CourseModel course, String departmentID) async {
    final courses =
        departments.firstWhere((element) => element.id == departmentID).courses;
    courses.removeWhere((e) => e.courseCode == course.courseCode);
    courses.add(course);
    await _api.updateCourse(courses, departmentID);
  }

  Future<void> deleteCourse(CourseModel course, String departmentID) async {
    final courses = departments
        .firstWhere((department) => department.id == departmentID)
        .courses;
    courses.removeWhere((element) => element.courseCode == course.courseCode);
    if (courses
        .where((element) => element.courseCode == course.courseCode)
        .isEmpty) {
      await _api.updateCourse(courses, departmentID);
    }
  }
}
