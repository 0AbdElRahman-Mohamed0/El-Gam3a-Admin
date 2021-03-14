import 'package:elgam3a_admin/models/day_model.dart';
import 'package:elgam3a_admin/services/vars.dart';

class HallModel {
  int id;
  int capacity;
  String building;

  List<DayModel> days = [
    DayModel().copyWith(
      name: 'Saturday',
    ),
    DayModel().copyWith(
      name: 'Sunday',
    ),
    DayModel().copyWith(
      name: 'Monday',
    ),
    DayModel().copyWith(
      name: 'Tuesday',
    ),
    DayModel().copyWith(
      name: 'Wednesday',
    ),
    DayModel().copyWith(
      name: 'Thursday',
    ),
    DayModel().copyWith(
      name: 'Friday',
    ),
  ];

  HallModel({this.id, this.capacity, this.building});

  HallModel.fromMap(Map<String, dynamic> m) {
    id = m[HallData.ID];
    capacity = m[HallData.CAPACITY];
    building = m[HallData.BUILDING];
  }

  Map<String, dynamic> toMap() {
    return {
      HallData.ID: id,
      HallData.CAPACITY: capacity,
      HallData.BUILDING: building,
      HallData.DAYS: days.map((day) => day.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'Hall $id';
  }
}
