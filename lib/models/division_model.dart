import 'package:elgam3a_admin/models/department_model.dart';
import 'package:elgam3a_admin/services/vars.dart';

class DivisionModel {
  String id;
  String name;
  List<DepartmentModel> departments = [];

  DivisionModel.fromMap(Map<String, dynamic> m) {
    id = m[DivisionData.ID];
    name = m[DivisionData.NAME];
    if (m[DivisionData.DEPARTMENTS] != null)
      m[DivisionData.DEPARTMENTS].forEach(
          (department) => departments.add(DepartmentModel.fromMap(department)));
  }

  @override
  String toString() {
    return name;
  }
}
