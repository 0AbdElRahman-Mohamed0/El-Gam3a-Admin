import 'package:elgam3a_admin/models/course_model.dart';
import 'package:elgam3a_admin/services/vars.dart';

class DepartmentModel {
  String id;
  String name;
  List<CourseModel> courses = [];

  DepartmentModel.fromMap(Map<String, dynamic> m) {
    id = m[DepartmentData.ID];
    name = m[DepartmentData.NAME];
    if (m[DepartmentData.COURSES] != null)
      m[DepartmentData.COURSES]
          .forEach((course) => courses.add(CourseModel.fromMap(course)));
  }

  @override
  String toString() {
    return name;
  }
}
