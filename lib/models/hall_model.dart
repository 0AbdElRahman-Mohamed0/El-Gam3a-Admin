import 'package:elgam3a_admin/services/vars.dart';

class HallModel {
  int id;
  int capacity;
  // String location;
  List<String> choosedTimes;

  HallModel({this.id, this.capacity});

  HallModel.fromMap(Map<String, dynamic> m) {
    id = m[HallData.ID];
    capacity = m[HallData.CAPACITY];
    // location = m[HallData.LOCATION];
  }

  Map<String, dynamic> toMap() {
    return {
      HallData.ID: id,
      HallData.CAPACITY: capacity,
      // HallData.LOCATION: location,
      HallData.TIMES: choosedTimes,
    };
  }

  @override
  String toString() {
    return 'Hall $id';
  }
}
